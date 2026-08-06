extends Area2D

class_name InteractArea2D

signal status_changed

@export var interact_name: String = "interact"
@export var active: bool = true:
	set(value):
		
		if active == value:
			return
		
		active = value
		status_changed.emit()

var interact: Callable = func() -> void: pass
