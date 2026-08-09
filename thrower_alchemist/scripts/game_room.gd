extends Node2D

class_name GameRoom

signal completed
signal room_started

@export var player_detector: Area2D

@export var _is_completed: bool = false
var is_completed: bool:
	get:
		return _is_completed

var started: bool = false

func complete() -> bool:
	
	if is_completed:
		return false
	
	_is_completed = true
	started = false
	completed.emit()
	
	return true

func can_start() -> bool:
	return not started and not is_completed

func start() -> bool:
	
	if not can_start():
		GameDebugger.debug_log(GameRoom, "The room " + self.name + " can't start")
		return false
	
	started = true
	room_started.emit()
	GameDebugger.debug_log(GameRoom, "The room " + self.name + " has started")
	return true
