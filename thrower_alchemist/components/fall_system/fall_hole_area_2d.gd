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

func _fall_target(target: Node2D, is_falling: bool) -> void:
	
	_toggle_movement(target, !is_falling)
	_toggle_flip(target, !is_falling)
	_play_animation(target, !is_falling)

func _play_animation(target: Node2D, value: bool) -> void:
	
	if value:
		return
	
	var animation_player: AnimationPlayer = ComponentManager.get_component(target, AnimationPlayer, true)
	
	if not animation_player:
		GameDebugger.debug_log(FallHoleArea2d, "Animation Player not founded")
		return
		
	if not animation_player.has_animation(&"falling"):
		GameDebugger.debug_log(FallHoleArea2d, "Animation not founded")
		return
	
	animation_player.play(&"falling")

func _toggle_movement(target: Node2D, value: bool) -> void:
	
	var move_component: MoveComponent2D = ComponentManager.get_component(target, MoveComponent2D, true)
	
	if not move_component:
		return
		
	move_component.can_move = value

func _toggle_flip(target: Node2D, value: bool) -> void:
	
	var flip_component: FlipComponent2D = ComponentManager.get_component(target, FlipComponent2D, true)
	
	if not flip_component:
		return
	
	flip_component.active = value
