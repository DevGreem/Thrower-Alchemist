extends Area2D

class_name FallHoleArea2D

@export var damage: float = 5.0
@export var tweener: TweenerAction
var shape: CollisionShape2D

func _ready() -> void:
	
	if not body_entered.is_connected(_on_body_entered):
		body_entered.connect(_on_body_entered)
	
	shape = ComponentManager.get_component(self, CollisionShape2D)

func _on_body_entered(body: Node2D) -> void:
	
	if body is not CollisionObject2D:
		return
	
	_fall_target(body)

func _fall_target(target: Node2D) -> void:
	
	var fall_component: BaseFallableComponent = ComponentManager.get_component(target, BaseFallableComponent)
	
	if not fall_component:
		return
	
	fall_component.try_fall(self)

func get_nearest_spawn_point(pos: Vector2, offset: Vector2) -> Vector2:
	
	if not shape:
		return pos
	
	if shape.shape is RectangleShape2D:
		return _rectangle_nearest_point_method(pos, offset, shape.shape as RectangleShape2D)
	
	return pos

func _rectangle_nearest_point_method(pos: Vector2, offset: Vector2, rectangle: RectangleShape2D) -> Vector2:
	
	var local_pos: Vector2 = shape.to_local(pos)
	var half: Vector2 = rectangle.size * 0.5
	
	var distances: Dictionary[Vector2, float] = {
		Vector2.LEFT: abs(local_pos.x + half.x),
		Vector2.RIGHT: abs(half.x - local_pos.x),
		Vector2.UP: abs(local_pos.y + half.y),
		Vector2.DOWN: abs(half.y - local_pos.y)
	}
	
	var close_side: Vector2 = Vector2.LEFT
	var close_distance: float = INF
	
	for side: Vector2 in distances:
		if distances[side] < close_distance:
			close_distance = distances[side]
			close_side = side
	
	var pos_sign: float
	if close_side.x != 0.0:
		pos_sign = signf(close_side.x)
		local_pos.x = half.x * pos_sign
		local_pos.x += offset.x * pos_sign
	else:
		pos_sign = signf(close_side.y)
		local_pos.y = half.y * pos_sign
		local_pos.y += offset.y * pos_sign
	
	return shape.to_global(local_pos)
