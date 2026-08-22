extends Node

class_name ProcessVisibilityNode

@export var target: CanvasItem
@export var show_is_processing: bool = true

func _process(_delta: float) -> void:
	target.visible = target.can_process() == show_is_processing
