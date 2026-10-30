-- Переход видимости; состояние можно передать из владельца
local K = require "kompot:kompot"
local Transition = require "kompot:kompot/core/transition"

return function(visible, spec, provided)
    assert(
        provided == nil or Transition.is_state(provided),
        "visibility expects a transition state"
    )
    local own = K.transition_state(visible)
    local state = provided or own
    if not provided then
        state.target_state = visible
    end
    assert(
        type(state.target_state) == "boolean" and type(state.current_state) == "boolean",
        "visibility transition states must be boolean"
    )
    local transition = K.transition(state)
    local value = transition:animate(function(shown)
        return shown and 1 or 0
    end, spec)
    return math.max(0, math.min(1, value)),
        not state.target_state and not transition:_is_running(),
        state.target_state
end
