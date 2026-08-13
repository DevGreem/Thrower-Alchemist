extends LimboState

class_name FallingState

@export var move_component: MoveComponent2D
@export var flip_component: FlipComponent2D

func _enter() -> void:
	
	if move_component:
		move_component.can_move = false
	
	if flip_component:
		flip_component.active = false

func _exit() -> void:
	
	if move_component:
		move_component.can_move = true
	
	if flip_component:
		flip_component.active = true
