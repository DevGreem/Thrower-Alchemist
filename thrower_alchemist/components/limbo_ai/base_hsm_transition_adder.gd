@abstract
@tool
extends Node

class_name BaseHSMTransitionAdder

@export var state_machine: LimboStateMachine

@export var custom_transition_name: bool = false:
	set(value):
		custom_transition_name = value
		notify_property_list_changed()

@export var auto_add_transition: bool = true

@export var _transition_name: StringName
var transition_name: StringName:
	get: return get_transition_name()

@export var from_state: LimboState
@export var to_state: LimboState
var guard: Callable = Callable()

func _ready() -> void:
	
	if Engine.is_editor_hint():
		return
	
	if auto_add_transition:
		register_transition()

func register_transition() -> void:
	
	if state_machine.has_transition(from_state, transition_name):
		state_machine.remove_transition(from_state, transition_name)
	
	state_machine.add_transition(from_state, to_state, transition_name, guard)

func get_transition_name() -> StringName:
	
	if custom_transition_name:
		return _transition_name
	
	return str(from_state) + "-" + str(to_state)

@abstract
func trigger() -> void

func _validate_property(property: Dictionary) -> void:
	
	if property.name == "_transition_name":
		
		if not custom_transition_name:
			property.usage |= PROPERTY_USAGE_READ_ONLY
