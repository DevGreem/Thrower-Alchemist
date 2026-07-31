extends Node

class_name InputManagerComponent

func activate_all() -> void:
	for child: Node in get_children():
		
		if child is InputComponent:
			child.active = true

func deactivate_all() -> void:
	
	for child: Node in get_children():
		
		if child is InputComponent:
			child.active = false
