@tool
extends TriggerNode

class_name ExecuteTrigger

@export var target: Node:
	set(value):
		target = value
		notify_property_list_changed()
		update_configuration_warnings()
		
@export var method: StringName

func execute(...parameters: Array) -> void:
	target.callv(method, parameters)

func _validate_property(property: Dictionary) -> void:
	
	super._validate_property(property)
	
	if not target:
		return
	
	if property.name == "method":
		var methods: Array = PropertiesUtilities.get_properties_names(target.get_method_list())
		
		property.hint = PROPERTY_HINT_ENUM
		property.hint_string = ",".join(methods)
	
