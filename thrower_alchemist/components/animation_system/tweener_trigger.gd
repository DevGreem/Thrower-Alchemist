@tool
extends TriggerNode

class_name TweenerTrigger

@export var animator: TweenerAnimator

func _execute(..._parameters: Array) -> void:
	animator.make_animation()
