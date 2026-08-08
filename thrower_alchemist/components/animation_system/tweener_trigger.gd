@tool
extends Node

class_name TweenerTrigger

@export var node: Node:
	set(value):
		node = value
		notify_property_list_changed()
		update_configuration_warnings()

@export var signal_to_connect: StringName

@export var animator: TweenerAnimator

func _ready() -> void:
	
	if not node:
		GameDebugger.debug_warning(TweenerTrigger, "Node not assigned")
		return
	
	if not animator:
		GameDebugger.debug_warning(TweenerTree, "Animator not assigned")
		return
	
	if not node.is_connected(signal_to_connect, _execute_animator):
		node.connect(signal_to_connect, _execute_animator)

func _execute_animator(..._parameters: Array) -> void:
	animator.make_animation()

func _get_names(properties: Array[Dictionary]) -> Array:
	return properties.map(
		func(property: Dictionary) -> StringName:
			return property.name
	)

func _validate_property(property: Dictionary) -> void:
	
	if node:
		if property.name == "signal_to_connect":
			
			var signals: Array = _get_names(node.get_signal_list())
			
			property.hint = PROPERTY_HINT_ENUM
			property.hint_string = ",".join(signals)

func _get_configuration_warnings() -> PackedStringArray:
	
	var warnings: PackedStringArray = []
	
	if not node:
		warnings.append("You must assign a node")
	
	return warnings
