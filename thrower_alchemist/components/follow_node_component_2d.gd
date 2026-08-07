extends Node

class_name FollowNodeComponent2D

@export var actor: Node2D
@export var target: Node2D

func _process(_delta: float) -> void:
	
	if not actor or not target:
		return
	
	actor.global_position = target.global_position
