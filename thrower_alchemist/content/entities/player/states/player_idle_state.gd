extends LimboState

class_name PlayerIdleState

@export var move_input: MoveInputComponent2D
@export var transition: BaseHSMTransitionAdder

func _update(_delta: float) -> void:
	
	if move_input.axis != Vector2.ZERO:
		transition.trigger()
