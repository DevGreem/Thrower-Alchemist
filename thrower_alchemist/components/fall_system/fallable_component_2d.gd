@abstract
extends BaseFallableComponent

class_name FallableComponent2D

@export var actor: Node2D = get_parent()
@export var spawn_offset: Vector2 = Vector2(4.0, 4.0)

func _respawn(source: FallHoleArea2D) -> void:
	get_spawn_pos(source)

func get_spawn_pos(source: FallHoleArea2D) -> void:
	
	var shape_node: CollisionShape2D = ComponentManager.get_component(source, CollisionShape2D)
	var shape: Shape2D = source.get_shape()
	
	if shape is RectangleShape2D:
		_rect_spawn_method(shape_node, shape as RectangleShape2D)
		return

func _rect_spawn_method(shape_node: CollisionShape2D, shape: RectangleShape2D) -> void:
	
	var local_pos: Vector2 = shape_node.to_local(actor.global_position)
	var half_size: Vector2 = shape.size/2
	
	if abs(local_pos.x) > abs(local_pos.y):
		local_pos.x = signf(local_pos.x) * (half_size.x + spawn_offset.x)
	else:
		local_pos.y = signf(local_pos.y) * (half_size.y + spawn_offset.y)
	
	actor.global_position = shape_node.to_global(local_pos)
