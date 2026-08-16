extends Node

class_name ChangeSceneNode

@export_file("*.tscn") var scene_file: String

func change() -> void:
	ScenesManager.change_scene(scene_file)
