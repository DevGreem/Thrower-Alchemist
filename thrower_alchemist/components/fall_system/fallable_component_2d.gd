@abstract
extends BaseFallableComponent

class_name FallableComponent2D

@export var actor: Node2D = get_parent()
@export var spawn_offset: Vector2 = Vector2(4.0, 4.0)

func _respawn(source: FallHoleArea2D) -> void:
	
	var spawn_pos: Vector2 = source.get_nearest_spawn_point(actor.global_position, spawn_offset)
	
	actor.global_position = spawn_pos
