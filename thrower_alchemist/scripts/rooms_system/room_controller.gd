extends Node

class_name RoomController

signal started
signal completed

enum State {
	INACTIVE,
	STARTED,
	COMPLETED
}

@export var objectives: Node
@export var doors_container: Node

var _room_state: State = State.INACTIVE
var room_state: State:
	get: return _room_state

func _ready() -> void:
	
	if not objectives:
		set_state(State.COMPLETED)

func set_state(new_state: State, force: bool = false) -> bool:
	
	if not force:
		if room_state == State.COMPLETED:
			return false
	
	_room_state = new_state
	return true

func _on_set_state() -> void:
	
	if room_state == State.STARTED:
		GameDebugger.debug_log(RoomController, "Starting room")
		started.emit()
	elif room_state == State.COMPLETED:
		GameDebugger.debug_log(RoomController, "Room Completed")
		open_doors()
		completed.emit()

func start() -> void:
	
	var ok: bool = set_state(State.STARTED)
	
	if not ok:
		return
	
	close_doors()

func close_doors() -> void:
	
	for door: Node in doors_container.get_children():
		
		if door is BlockDoorNode:
			door.close()

func open_doors() -> void:
	
	for door: Node in doors_container.get_children():
		
		if door is BlockDoorNode:
			door.open()
