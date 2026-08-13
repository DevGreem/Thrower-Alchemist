extends Node

class_name MoveComponent2D

@export var actor: CharacterBody2D
@export var can_move: bool = true
@export var can_change_direction: bool = true

@export var speed: float

var _direction: Vector2 = Vector2.ZERO
var direction: Vector2:
	get: return _direction
	set(value): return

func _physics_process(_delta: float) -> void:
	
	if not can_move:
		return
	
	actor.velocity = speed*direction
	actor.move_and_slide()

func set_direction(value: Vector2) -> bool:
	
	if not can_change_direction:
		return false
	
	self._direction = value
	return true
