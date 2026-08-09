extends Node

const DEFAULT_ENEMIES_CANTITY: int = INT64_MAX

var actual_room: GameRoom
var enemies_cantity: int = DEFAULT_ENEMIES_CANTITY
var killed_enemies: int = 0:
	set = _on_set_killed_enemies

func start_room(room: GameRoom, max_enemies: int = -1, execute_start: bool = true) -> bool:
	
	if room == actual_room:
		return false
	
	if not room.can_start():
		GameDebugger.debug_log_string("RoomManager", "The room " + room.name + " can't start")
		return false
	
	actual_room = room
	
	if execute_start:
		actual_room.start()
	
	killed_enemies = 0
	
	if max_enemies == -1:
		#TODO: Add detection of spawners
		enemies_cantity = 0
	else:
		enemies_cantity = max_enemies
	
	GameDebugger.debug_log_string("RoomManager", "The room " + room.name + " has started")
	return true

func complete_room(execute_complete: bool = true) -> void:
	
	if actual_room.started:
		killed_enemies = 0
		enemies_cantity = DEFAULT_ENEMIES_CANTITY
	
	if execute_complete:
		actual_room.complete()

func _on_set_killed_enemies(value: int) -> void:
	
	killed_enemies = value
	
	if killed_enemies >= enemies_cantity:
		complete_room()
