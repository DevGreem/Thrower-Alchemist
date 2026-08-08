@tool
extends TriggerNode

class_name ExecuteTrigger

@export var target: Node:
	set(value):
		target = value
		notify_property_list_changed()
		update_configuration_warnings()
		
@export var method: StringName

func _execute(..._parameters: Array) -> void:
	target.call(method)

func _validate_property(property: Dictionary) -> void:
	
	if not target:
		return
	
	if property.name == "method":
		var methods: Array = _get_names(target.get_method_list())
		
		property.hint = PROPERTY_HINT_ENUM
		property.hint_string = ",".join(methods)
	
