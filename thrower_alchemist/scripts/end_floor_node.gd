extends Node

class_name EndFloorNode

@export var end_run: bool = false

func end_floor() -> void:
	
	if end_run:
		# Temporal end game
		get_tree().quit()
		return
	
	
