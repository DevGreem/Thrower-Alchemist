@tool
extends TriggerNode

class_name ExecuteTrigger

const METHOD_STRING: String = 'Executing the method "%s" of the node %s (%s)'

@export var target: Node:
	set(value):
		target = value
		notify_property_list_changed()
		update_configuration_warnings()
		
@export var method: StringName

func execute(...parameters: Array) -> void:
	var params: int = target.get_method_argument_count(method)
	
	if parameters.size() > params:
		
		if params > 0:
			parameters = parameters.slice(0, parameters.size(), 1, true)
		
		GameDebugger.debug_warning(
			ExecuteTrigger,
			METHOD_STRING % [method, target.name, str(target)] + "with less parameters than the required\n" +
			"The method need " + str(params) + " parameters but " + str(parameters.size()) + " was given"
		)
	
	GameDebugger.debug_log(ExecuteTrigger, METHOD_STRING % [method, target.name, str(target)])
	if params == 0:
		target.call(method)
	else:
		target.callv(method, parameters)

func _validate_property(property: Dictionary) -> void:
	
	super._validate_property(property)
	
	if not target:
		return
	
	if property.name == "method":
		var methods: Array = PropertiesUtilities.get_properties_names(target.get_method_list())
		
		property.hint = PROPERTY_HINT_ENUM
		property.hint_string = ",".join(methods)
	
