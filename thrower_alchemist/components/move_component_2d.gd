extends Node

class_name MoveComponent2D

signal collision_detected(collider: KinematicCollision2D)

@export var actor: CharacterBody2D
@export var can_move: bool = true
@export var speed: float
@export var detect_collisions: bool = false
var direction: Vector2 = Vector2.ZERO

func _physics_process(_delta: float) -> void:
	
	if not can_move:
		return
	
	actor.velocity = speed*direction
	
	if not detect_collisions:
		actor.move_and_slide()
		return
		
	var collider: KinematicCollision2D = actor.move_and_collide(actor.velocity * get_physics_process_delta_time())
	
	if collider:
		collision_detected.emit(collider)
