extends Node

class_name MoveComponent2D

@export var actor: CharacterBody2D
@export var can_move: bool = true
@export var speed: Vector2
@export var direction: Vector2

func _physics_process(delta: float) -> void:
	
	if not can_move:
		return
	
	actor.velocity = speed*delta*direction
	actor.move_and_slide()
