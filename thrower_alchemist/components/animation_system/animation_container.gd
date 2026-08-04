@tool
extends Control

class_name AnimationContainer

func _notification(what: int) -> void:
	
	if what == NOTIFICATION_CHILD_ORDER_CHANGED:
		custom_minimum_size = get_combined_minimum_size()
		GameDebugger.debug_log(AnimationContainer, "Changed minimun size")
