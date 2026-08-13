extends Area2D

class_name FallHoleArea2d

@export var tweener: TweenerAction

func _ready() -> void:
	
	if not body_entered.is_connected(_on_body_entered):
		body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	
	if body is not CollisionObject2D:
		return
	
	_fall_target(body, true)
	
	tweener.node = body
	tweener.make_animation()

## TODO: Change state of the target to falling
func _fall_target(target: Node2D, is_falling: bool) -> void:
	
	#var transition: Dictionary[Variant, Node] = ComponentManager.get_components(target, BaseHSMTransitionAdder)
	pass
