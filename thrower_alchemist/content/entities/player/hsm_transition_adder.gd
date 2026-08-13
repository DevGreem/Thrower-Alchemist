extends Node

class_name HSMTransitionAdder

@export var state_machine: LimboStateMachine
@export var transition_name: StringName
@export var from_state: LimboState
@export var to_state: LimboState
var guard: Callable = Callable()

func _ready() -> void:
	state_machine.add_transition(from_state, to_state, transition_name, guard)

func trigger() -> void:
	GameDebugger.debug_log(HSMTransitionAdder, "Executing transition to " + to_state.name)
	state_machine.dispatch(transition_name)
