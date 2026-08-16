@tool
extends TriggerNode

class_name TweenerTrigger

@export var animator: TweenerAnimator:
	set(value):
		animator = value
		update_configuration_warnings()

func execute(..._parameters: Array) -> void:
	GameDebugger.debug_log(TweenerTrigger, "Executing animation " + str(animator.name))
	animator.make_animation()

func _get_configuration_warnings() -> PackedStringArray:
	
	var warnings: PackedStringArray = super._get_configuration_warnings()
	
	if not animator:
		warnings.append("You must assign an animator")
	
	return warnings
