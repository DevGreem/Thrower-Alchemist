extends Node

class_name RoomController

signal started
signal completed

enum State {
	INACTIVE,
	STARTED,
	COMPLETED
}

@export var objectives: ObjectivesContainer
@export var doors_container: Node

var _room_state: State = State.INACTIVE
var room_state: State:
	get: return _room_state

func _ready() -> void:
	
	if not objectives:
		_set_state(State.COMPLETED)
		return
	
	if not objectives.all_completed.is_connected(complete):
		objectives.all_completed.connect(complete)

func _set_state(new_state: State, force: bool = false) -> bool:
	
	if room_state == new_state:
		return false
	
	if not force:
		if room_state == State.COMPLETED:
			return false
	
	_room_state = new_state
	return true

func start() -> void:
	
	var ok: bool = _set_state(State.STARTED)
	
	if not ok:
		return
	
	GameDebugger.debug_log(RoomController, "Room Started")
	started.emit()

func complete() -> void:
	
	var ok: bool = _set_state(State.COMPLETED)
	
	if not ok:
		return
	
	GameDebugger.debug_log(RoomController, "Room completed")
	completed.emit()
