extends Node

class_name ReachTimeComponent

signal reached

enum ComponentMode {
	PROCESS,
	PHYSICS
}

@export var actor: Node
## In seconds
@export var max_time_range: float
@export var activated: bool = true
@export var free_parent_on_reach: bool = true

var current_reached: float = 0

func _physics_process(delta: float) -> void:
	_update_distance(delta)

func _update_distance(delta: float) -> void:
	
	if current_reached > max_time_range:
		_on_reach()
		return
	
	current_reached += delta

func _on_reach() -> void:
	
	reached.emit()
	
	if free_parent_on_reach:
		get_parent().queue_free()
