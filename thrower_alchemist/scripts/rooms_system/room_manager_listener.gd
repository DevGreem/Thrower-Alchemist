extends Node

class_name RoomManagerListener

@export var signal_to_listen: StringName
@export var node: Node
@export var method_to_execute: StringName

func _validate_property(property: Dictionary) -> void:
	
	if property.name == "signal_to_listen":
		
		var signals: Array = _get_names(RoomManager.get_signal_list())
		
		property.hint = PROPERTY_HINT_ENUM
		property.hint_string = ",".join(signals)
	
	elif property.name == "method_to_execute":
		
		if not node:
			return
		
		var methods: Array = _get_names(RoomManager.get_method_list())
		
		property.hint = PROPERTY_HINT_ENUM
		property.hint_string = ",".join(methods)

func _get_names(arr: Array[Dictionary]) -> Array:
	return arr.map(
		func(prop: Dictionary) -> StringName:
			return prop.name
	)
