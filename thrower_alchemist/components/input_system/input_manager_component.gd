extends Node

class_name InputManagerComponent

func activate_all() -> void:
	for child: InputComponent in get_children():
		child.active = true

func deactivate_all() -> void:
	
	for child: InputComponent in get_children():
		child.active = false
