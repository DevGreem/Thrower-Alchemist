@tool
extends Node2D

class_name GameMap

@export var predefined_map: PackedScene = null:
	set(value):
		predefined_map = value
		
		if Engine.is_editor_hint():
			_show_map_in_editor()
		
@export var world_container: Node2D

var loaded_zone: GameZone

func _ready() -> void:
	
	if not world_container:
		GameDebugger.debug_error(GameMap, "No world container setted", true)
		return
	
	if Engine.is_editor_hint():
		_show_map_in_editor()
	else:
		generate_map()

func _instantiate_zone() -> GameZone:
	
	if not predefined_map:
		return null #TODO: Add random generation system
	
	var zone: GameZone = predefined_map.instantiate()
	
	return zone	

func _load_map() -> void:
	
	if predefined_map:
		loaded_zone = _instantiate_zone()
		
		if not loaded_zone:
			GameDebugger.debug_error(GameMap, "Zone not instantiated", true)
			return
		
		world_container.add_child(
			loaded_zone,
			true
		)
	else:
		GameDebugger.debug_warning(GameMap, "Random generation not added", true)

func generate_map() -> void:
	
	if predefined_map:
		_load_map()
		
		var container: GlobalSpawnContainer2D = SpawnManager2D.get_container(ContainerType.Enum.ENTITIES)
		container.spawn_node(PlayerManager.current_player)
		
		PlayerManager.current_player.global_position = loaded_zone.player_spawner.global_position

func _show_map_in_editor() -> void:
	
	if not Engine.is_editor_hint():
		return
	
	if not world_container:
		GameDebugger.debug_warning(GameMap, "No world container assigned", true)
		return
	
	if loaded_zone:
		loaded_zone.queue_free()
	
	var zone: GameZone = _instantiate_zone()
	
	if zone:
		zone.owner = null
		world_container.add_child(zone, false, Node.INTERNAL_MODE_FRONT)
