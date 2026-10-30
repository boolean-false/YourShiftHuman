-- Общее состояние группы анимаций; завершение публикуется после кадра
local R = require "kompot:kompot/core/runtime"
local Anim = require "kompot:kompot/core/anim"
local T = {}
local State = {}
local fields = {
    current_state = "_current",
    target_state = "_target",
    is_idle = "_idle",
    completion = "_completion",
}

State.__index = function(self, key)
    local field = fields[key]
    if field then
        return rawget(self, field).value
    end
end
State.__newindex = function(self, key, value)
    assert(key == "target_state", "transition state is read-only except target_state")
    if self._target:peek() == value then
        return
    end
    self._target:set(value)
    self._revision:set(self._revision:peek() + 1)
    self._idle:set(false)
end

function T.is_state(value)
    return getmetatable(value) == State
end

function T.new_state(initial)
    return setmetatable({
        _current = R.new_state(initial),
        _target = R.new_state(initial),
        _idle = R.new_state(true),
        _completion = R.new_state(0),
        _revision = R.new_state(0),
    }, State)
end

function T.state(initial)
    return R._remember("transition_state", function()
        return T.new_state(initial)
    end)
end

local Group = {}
Group.__index = Group

function Group:_detach()
    if self.bound and self.bound._owner == self then
        rawset(self.bound, "_owner", nil)
    end
    self.bound = nil
end

function Group:_is_running()
    for _, animation in ipairs(self.channels) do
        if animation.active then
            return true
        end
    end
    return false
end

local function valid_value(value)
    if type(value) == "number" then
        return value == value and math.abs(value) < math.huge
    end
    if type(value) ~= "table" or #value == 0 then
        return false
    end
    for i = 1, #value do
        if
            type(value[i]) ~= "number"
            or value[i] ~= value[i]
            or math.abs(value[i]) == math.huge
        then
            return false
        end
    end
    return true
end

function Group:animate(value_of, spec)
    assert(
        R.current_scope() == self.scope,
        "transition animations must belong to their transition's component"
    )
    assert(type(value_of) == "function", "transition:animate requires a value mapping")
    spec = spec or Anim.tween()
    local state = self.state
    local animation = R._remember("transition_animate", function()
        local initial = value_of(state._current:peek())
        assert(
            valid_value(initial),
            "transition mapping must return a finite number or numeric array"
        )
        return Anim._new(initial, spec)
    end, state)
    animation.scope = self.scope
    local target = value_of(self.target)
    assert(valid_value(target), "transition mapping must return a finite number or numeric array")
    if not Anim._equal(animation.to, target) then
        animation:start(target, spec)
        self.rt:add_anim(animation)
        state._idle:set(false)
    end
    self.channels[#self.channels + 1] = animation
    return animation.value
end

function T.transition(state)
    assert(T.is_state(state), "K.transition expects a transition state")
    local scope, rt = R.current_scope(), R.runtime()
    local group = R._remember("transition", function()
        return setmetatable({
            channels = {},
        }, Group)
    end)
    R.on_dispose(function()
        group:_detach()
    end)
    if group.state ~= state then
        for _, animation in ipairs(group.channels) do
            animation.dead = true
        end
        group.pending = false
    end
    local channels = {}
    local target, revision = state._target.value, state._revision.value
    group.state, group.target, group.channels, group.scope, group.rt =
        state, target, channels, scope, rt
    R.effect(function()
        if group.bound ~= state then
            group:_detach()
        end
        assert(
            not state._owner or state._owner == group,
            "transition state already belongs to another transition"
        )
        rawset(state, "_owner", group)
        group.bound = state
        -- Более ранний эффект мог уже запросить другую цель
        if revision ~= state._revision:peek() then
            return
        end
        for _, animation in ipairs(channels) do
            if animation.active then
                group.pending = true
                return
            end
        end
        if state._idle:peek() then
            return
        end
        local completed = group.pending or state._current:peek() ~= target
        group.pending = false
        state._current:set(target)
        state._idle:set(true)
        if completed then
            state._completion:set(state._completion:peek() + 1)
        end
    end, state, revision, rt.frame)
    return group
end

return T
