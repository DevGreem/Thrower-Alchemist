extends Node

class_name ReachDistanceComponent2D

signal reached

@export var move_component: MoveComponent2D
@export var activated: bool = true

@export var reach_distance: float
@export var free_parent_on_reach: bool = true

var traveled_distance: float = 0.0

func _physics_process(delta: float) -> void:
	traveled_distance += move_component.speed * delta
	
	_verify_reached()

func _verify_reached() -> void:
	
	if traveled_distance < reach_distance:
		return
	
	reached.emit()
	
	if free_parent_on_reach:
		get_parent().queue_free()
