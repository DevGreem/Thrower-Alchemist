@tool
@abstract
extends ITrigger

class_name TriggerNode

@export var signal_to_connect: StringName:
	set(value):
		signal_to_connect = value
		notify_property_list_changed()
		update_configuration_warnings()

func _ready() -> void:
	super._ready()
	
	if Engine.is_editor_hint():
		return
	
	if not node.is_connected(signal_to_connect, execute):
		node.connect(signal_to_connect, execute)

@abstract
func execute(..._parameters: Array) -> void

func _validate_property(property: Dictionary) -> void:
	
	if node:
		if property.name == "signal_to_connect":
			
			var signals: Array = PropertiesUtilities.get_properties_names(node.get_signal_list())
			
			property.hint = PROPERTY_HINT_ENUM
			property.hint_string = ",".join(signals)

func _get_configuration_warnings() -> PackedStringArray:
	
	var warnings: PackedStringArray = super._get_configuration_warnings()
	
	if not signal_to_connect:
		warnings.append("You must assign a signal")
	
	return warnings
