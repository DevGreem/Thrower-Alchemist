@tool
extends BaseHSMTransitionAdder

class_name HSMBidirectionalTransitionAdder

@export var _reverse_transition_name: StringName
var reverse_transition_name: StringName:
	get: return get_transition_name(true)

var reverse_guard: Callable = Callable()

func register_transition() -> void:
	
	if state_machine.has_transition(from_state, get_transition_name()):
		state_machine.remove_transition(from_state, get_transition_name())
	
	state_machine.add_transition(
		from_state,
		to_state,
		get_transition_name(),
		guard
	)
	
	if state_machine.has_transition(to_state, get_transition_name(true)):
		state_machine.remove_transition(to_state, get_transition_name(true))
	
	state_machine.add_transition(
		to_state,
		from_state,
		get_transition_name(true),
		reverse_guard
	)

func get_transition_name(inverse: bool = false) -> StringName:
	
	if not inverse:
		return super.get_transition_name()
	
	if custom_transition_name:
		return _reverse_transition_name
	
	return str(to_state) + "-" + str(from_state)

func trigger() -> void:
	
	var current_state: LimboState = state_machine.get_active_state()
	
	if current_state == from_state:
		GameDebugger.debug_log(
			HSMBidirectionalTransitionAdder,
			'Changing to state "' + transition_name + '"'
		)
		state_machine.dispatch(transition_name)
		triggered.emit()
		
	elif current_state == to_state:
		GameDebugger.debug_log(
			HSMBidirectionalTransitionAdder,
			'Changing to state "' + reverse_transition_name + '"'
		)
		state_machine.dispatch(reverse_transition_name)
		triggered.emit()

func _validate_property(property: Dictionary) -> void:
	
	super._validate_property(property)
	
	if property.name == "_reverse_transition_name":
		
		if not custom_transition_name:
			property.usage |= PROPERTY_USAGE_READ_ONLY
