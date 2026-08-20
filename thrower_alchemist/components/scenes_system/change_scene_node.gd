@tool
extends Node

class_name ChangeSceneNode

@export var quit_game: bool = false:
	set(value):
		quit_game = value
		notify_property_list_changed()

@export_file("*.tscn") var scene_file: String
@export var min_wait_time: float = -1.0

func change() -> void:
	if Engine.is_editor_hint():
		return
	
	if quit_game:
		ScenesManager.close_game()
		return
	
	ScenesManager.load_scene(scene_file, min_wait_time)

func _validate_property(property: Dictionary) -> void:
	
	if property.name == "scene_file":
		if quit_game:
			property.usage = PROPERTY_USAGE_NO_EDITOR
