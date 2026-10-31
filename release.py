import argparse
import json
import re
import tomllib
from pathlib import Path
from zipfile import ZIP_DEFLATED, ZipFile


ROOT = Path(__file__).resolve().parent
EXCLUDED_PACKS = {"contour", "editor"}


def add_folder(archive, folder, destination):
    for path in sorted(folder.rglob("*")):
        if path.is_file() and not any(
            part in {".git", "__pycache__"} for part in path.relative_to(folder).parts
        ):
            archive.write(path, (destination / path.relative_to(folder)).as_posix())


def clean_world(level):
    indices = json.loads((level / "indices.json").read_text(encoding="utf-8-sig"))
    removed_items = {
        index for index, name in enumerate(indices.get("items", []))
        if name.split(":", 1)[0] in EXCLUDED_PACKS
    }
    for kind in ("blocks", "items", "entities"):
        names = indices.get(kind, [])
        while names and names[-1].split(":", 1)[0] in EXCLUDED_PACKS:
            names.pop()
        if any(name.split(":", 1)[0] in EXCLUDED_PACKS for name in names):
            raise ValueError(
                f"Мир {level.name}: {kind} требуют перенумерации. "
                "Пересохрани мир без contour и editor перед сборкой"
            )

    result = {"indices.json": json.dumps(indices, ensure_ascii=False, indent=2)}
    player_path = level / "player.json"
    if player_path.is_file():
        player = json.loads(player_path.read_text(encoding="utf-8-sig"))
        for entry in player.get("players", []):
            slots = entry.get("inventory", {}).get("slots", [])
            for index, slot in enumerate(slots):
                if slot.get("id") in removed_items:
                    slots[index] = {"id": 0}
        result["player.json"] = json.dumps(player, ensure_ascii=False, indent=2)
    return result


def build(output, worlds):
    project_text = (ROOT / "project.toml").read_text(encoding="utf-8-sig")
    project = tomllib.loads(project_text)
    packs = [name for name in project["base_packs"] if name not in EXCLUDED_PACKS]
    project_text = re.sub(
        r"(?m)^base_packs\s*=\s*\[[^\]]*\]",
        lambda match: "base_packs = " + json.dumps(packs, ensure_ascii=False),
        project_text,
        count=1,
    )

    levels = sorted(
        (path for path in worlds.iterdir() if path.is_dir() and path.name.isdecimal()),
        key=lambda path: int(path.name),
    ) if worlds.is_dir() else []
    if not levels:
        raise ValueError(f"Нет миров уровней 1, 2, 3 и т.д. в {worlds}")
    for level in levels:
        if not (level / "world.json").is_file():
            raise ValueError(f"В уровне {level.name} нет world.json")
    prepared_worlds = {level.name: clean_world(level) for level in levels}
    for name in ("icon.png", "start.lua"):
        if not (ROOT / name).is_file():
            raise ValueError(f"Не найден {name}")

    output.parent.mkdir(parents=True, exist_ok=True)
    temporary = output.with_name(output.name + ".tmp")
    try:
        with ZipFile(temporary, "w", compression=ZIP_DEFLATED) as archive:
            for pack in sorted((ROOT / "content").iterdir()):
                if pack.is_dir() and pack.name not in EXCLUDED_PACKS:
                    add_folder(archive, pack, Path("content") / pack.name)
            for level in levels:
                # Редактор убираем и из списка паков каждого мира
                for path in sorted(level.rglob("*")):
                    if not path.is_file():
                        continue
                    relative = path.relative_to(level)
                    destination = (Path("worlds") / level.name / relative).as_posix()
                    if relative.as_posix() in prepared_worlds[level.name]:
                        archive.writestr(destination, prepared_worlds[level.name][relative.as_posix()])
                    elif relative.as_posix() == "packs.list":
                        names = path.read_text(encoding="utf-8-sig").splitlines()
                        names = [name for name in names if name.strip() not in EXCLUDED_PACKS]
                        archive.writestr(destination, "\n".join(names) + "\n")
                    else:
                        archive.write(path, destination)
            archive.writestr("project.toml", project_text)
            archive.write(ROOT / "icon.png", "icon.png")
            archive.write(ROOT / "start.lua", "start.lua")
            if (ROOT / "LICENSE").is_file():
                archive.write(ROOT / "LICENSE", "LICENSE")
        temporary.replace(output)
    finally:
        temporary.unlink(missing_ok=True)
    print(f"Готово: {output}")
    print("Уровни: " + ", ".join(level.name for level in levels))


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Собрать ZIP проекта без движка")
    parser.add_argument("--output", type=Path, default=ROOT / "export" / "release.zip")
    parser.add_argument("--worlds", type=Path, default=ROOT / "worlds")
    args = parser.parse_args()
    try:
        build(args.output.resolve(), args.worlds.resolve())
    except (OSError, ValueError) as error:
        parser.exit(1, f"Не удалось собрать релиз: {error}\n")
