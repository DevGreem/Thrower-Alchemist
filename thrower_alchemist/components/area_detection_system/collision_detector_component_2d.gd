extends Node

class_name CollisionDetectorComponent2D

@export var node: CharacterBody2D

signal collision_detected(body: Object)

func _physics_process(_delta: float) -> void:
	
	var count: int = node.get_slide_collision_count()
	
	if count == 0:
		return
	
	for i: int in range(count):
		
		var collision: KinematicCollision2D = node.get_slide_collision(i)
		var collider: Object = collision.get_collider()
		
		if not collider:
			continue
		
		collision_detected.emit(
			collider
		)
