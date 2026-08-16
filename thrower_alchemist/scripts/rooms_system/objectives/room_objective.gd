@abstract
extends Node

class_name RoomObjective

signal completed

var _is_completed: bool = false
var is_completed: bool:
	get: return _is_completed

func complete() -> void:
	_is_completed = true
	completed.emit()
	GameDebugger.debug_log(RoomObjective, 'Completed objective "' + self.name + '"')
