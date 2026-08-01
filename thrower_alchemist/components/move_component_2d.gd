extends Node

class_name MoveComponent2D

@export var actor: CharacterBody2D
@export var can_move: bool = true
@export var speed: float
var direction: Vector2 = Vector2.ZERO

func _physics_process(_delta: float) -> void:
	
	if not can_move:
		return
	
	actor.velocity = speed*direction
	actor.move_and_slide()
