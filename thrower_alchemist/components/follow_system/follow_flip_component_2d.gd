@tool
extends Node

class_name FollowFlipComponent2D

@export var node: Node2D:
	set(value):
		node = value
		update_configuration_warnings()

@export var target: Node2D:
	set(value):
		target = value
		update_configuration_warnings()

@export var flip_x: bool = true:
	set(value):
		flip_x = value
		update_configuration_warnings()

@export var flip_y: bool = false:
	set(value):
		flip_y = value
		update_configuration_warnings()

func _process(_delta: float) -> void:
	
	if Engine.is_editor_hint():
		return
	
	if not target or not node:
		return
	
	var direction: Vector2 = node.global_position.direction_to(target.global_position)
	
	if flip_x:
		if direction.x < 0:
			node.flip_h = true
		elif direction.x > 0:
			node.flip_h = false
	
	if flip_y:
		if direction.y < 0:
			node.flip_v = true
		elif direction.y > 0:
			node.flip_v = false

func _get_configuration_warnings() -> PackedStringArray:
	
	var warnings: PackedStringArray = []
	
	if not node:
		warnings.append("You must assign a node")
	
	if not target:
		warnings.append("You must assign a target")
	
	if flip_x:
		if "flip_h" not in node:
			warnings.append('Target must had the property "flip_h"')
	
	if flip_y:
		if "flip_v" not in node:
			warnings.append('Target must had the property "flip_v"')
	
	return warnings
