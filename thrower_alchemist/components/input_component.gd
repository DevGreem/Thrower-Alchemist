extends Node

class_name InputComponent

@export var actor: Node2D
@export var action: String

var function: Callable

func _input(event: InputEvent) -> void:
	
	if event.is_action(action) and event.is_pressed():
		function.call()
