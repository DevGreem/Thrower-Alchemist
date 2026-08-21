extends Node

class_name EndFloorNode

@export var end_run: bool = false

func end_floor() -> void:
	
	if end_run:
		# Temporal end game
		ScenesManager.change_to_file(ProjectSettings.get_setting("application/run/main_scene") as String)
		return
	
	
