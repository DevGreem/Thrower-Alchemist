extends Node2D

class_name GameMap

@export var predefined_map: PackedScene = null
@export var world_container: Node2D

var loaded_zone: GameZone

func _ready() -> void:
	
	if predefined_map:
		loaded_zone = predefined_map.instantiate()
		
		world_container.add_child(
			loaded_zone,
			true
		)
		
		
		EventBus.spawn_node(
			PlayerManager.current_player,
			ContainerType.Enum.ENTITIES_CONTAINER
		)
		
		PlayerManager.current_player.global_position = loaded_zone.player_spawner.global_position
