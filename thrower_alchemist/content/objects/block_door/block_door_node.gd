extends StaticBody2D

class_name BlockDoorNode

signal opened
signal closed

@export var start_open: bool = false

func _ready() -> void:
	
	if start_open:
		open()

func open() -> void:
	opened.emit()
	GameDebugger.debug_log(BlockDoorNode, "Door Opened")

func close() -> void:
	closed.emit()
	GameDebugger.debug_log(BlockDoorNode, "Door Closed")
