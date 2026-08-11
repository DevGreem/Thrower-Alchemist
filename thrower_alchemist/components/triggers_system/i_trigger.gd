@abstract
@tool
extends Node

class_name ITrigger

@export var node: Node:
	set(value):
		node = value
		notify_property_list_changed()
		update_configuration_warnings()

func _ready() -> void:
	
	if not node:
		GameDebugger.debug_warning(TriggerNode, "Node not assigned")
		return

@abstract
func execute(..._parameters: Array) -> void

func _get_configuration_warnings() -> PackedStringArray:
	
	var warnings: PackedStringArray = []
	
	if not node:
		warnings.append("You must assign a node")
	
	return warnings
