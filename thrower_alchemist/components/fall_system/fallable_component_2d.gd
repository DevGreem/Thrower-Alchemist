@abstract
extends BaseFallableComponent

class_name FallableComponent2D

@export var actor: Node2D = get_parent()
@export var spawn_offset: Vector2 = Vector2(4.0, 4.0)
var fall_pos: Vector2

func try_fall(source: FallHoleArea2D) -> void:
	
	if not active:
		return
	
	fall_pos = self.actor.global_position
	_fall(source)
	
	if free_on_fall:
		actor.queue_free()

func _respawn(source: FallHoleArea2D) -> void:
	
	var spawn_pos: Vector2 = source.get_nearest_spawn_point(
		fall_pos,
		spawn_offset
	)
	
	actor.global_position = spawn_pos
