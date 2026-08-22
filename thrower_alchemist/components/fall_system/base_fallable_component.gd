@icon("res://addons/at-icons/node2d/golf_hole.svg")
@abstract
extends Node

class_name BaseFallableComponent

@export var active: bool = true
@export var free_on_fall: bool = false

@abstract
func _fall(source: FallHoleArea2D) -> void

func try_fall(source: FallHoleArea2D) -> void:
	
	if not active:
		return
	
	_fall(source)
	
	if free_on_fall:
		queue_free()

@abstract
func _respawn(source: FallHoleArea2D) -> void

func try_spawn(source: FallHoleArea2D) -> void:
	
	if not active:
		return
	
	_respawn(source)
