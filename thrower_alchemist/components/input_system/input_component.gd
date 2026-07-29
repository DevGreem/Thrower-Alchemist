@abstract
extends Node

class_name InputComponent

@export var original_process: Node.ProcessMode
@export var actor: Node2D
@export var active: bool = true:
	set(value):
		
		if value == active:
			return
		
		active = value
		_on_set_active()

func _init() -> void:
	original_process = self.process_mode

func _on_set_active() -> void:
	if not active:
		self.process_mode = Node.PROCESS_MODE_DISABLED
		self.physics_interpolation_mode = Node.PHYSICS_INTERPOLATION_MODE_OFF
	else:
		self.process_mode = original_process
		self.physics_interpolation_mode = Node.PHYSICS_INTERPOLATION_MODE_ON
