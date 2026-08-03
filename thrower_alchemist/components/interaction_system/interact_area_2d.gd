extends Area2D

class_name InteractArea2D

@export var interact_name: String = "interact"
@export var active: bool = true

var interact: Callable = func(_caller: Node2D) -> void: pass
