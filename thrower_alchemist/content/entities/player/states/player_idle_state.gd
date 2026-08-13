extends LimboState

class_name PlayerIdleState

@export var move_component: MoveComponent2D
@export var transition: HSMTransitionAdder

func _update(_delta: float) -> void:
	
	if move_component.direction != Vector2.ZERO:
		transition.trigger()
