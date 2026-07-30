extends ShareableResource

class_name ResourceTimer

signal wait_time_changed
signal timeout

@export var wait_time: float:
	set(value):
		
		if wait_time == value:
			return
		
		wait_time = value
		_on_wait_time_changed()

@export var _time_left: float
var time_left: float:
	get: return _time_left
	set(value):
		assert(false, "You can't change the value of time_left directly!")

@export var _started: bool = false
var started: bool:
	get: return _started
	set(value):
		assert(false, "You can't change the value of started directly!")

@export var paused: bool = false
@export var one_shot: bool = false

var executed: int = 0

func process(delta: float) -> void:
	
	if not started:
		return
	
	_time_left -= delta
	
	if time_left <= 0:
		timeout.emit()
		
		if one_shot:
			stop()
		else:
			start()
	
func start() -> void:
	_started = true
	_time_left = wait_time

func stop() -> void:
	_started = false

func pause() -> void:
	paused = true

func resume() -> void:
	paused = false

func _on_wait_time_changed() -> void:
	wait_time_changed.emit()
	
	if started:
		return
	
	_time_left = wait_time
