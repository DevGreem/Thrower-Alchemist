@tool
extends Control

class_name AnimationContainer

func _get_minimum_size() -> Vector2:
	
	if get_child_count() == 0:
		return Vector2.ZERO
	
	var child: Control = get_child(0)
	return child.size
