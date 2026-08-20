extends Control

class_name LoadingScreen

func _ready() -> void:
	ScenesLoaderManager.load_screen_loaded()
