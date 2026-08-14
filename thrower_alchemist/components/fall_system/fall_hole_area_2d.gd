extends Area2D

class_name FallHoleArea2D

@export var damage: float = 5.0
@export var tweener: TweenerAction

func _ready() -> void:
	
	if not body_entered.is_connected(_on_body_entered):
		body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	
	if body is not CollisionObject2D:
		return
	
	_fall_target(body, true)

## TODO: Change state of the target to falling
func _fall_target(target: Node2D, is_falling: bool) -> void:
	
	var fall_component: BaseFallableComponent = ComponentManager.get_component(target, BaseFallableComponent)
	
	if not fall_component:
		return
	
	fall_component.try_fall(self)
