@abstract
@tool
extends ISpawn

class_name BaseSpawner

signal spawned

enum SpawnType {
	ONE_TIME,
	RESPAWN
}

@export var scene: PackedScene:
	set(value):
		scene = value
		notify_property_list_changed()
		update_configuration_warnings()

@export var spawn_type: SpawnType:
	set(value):
		spawn_type = value
		update_configuration_warnings()
		notify_property_list_changed()

@export var spawn_deferred: bool = false

@export_tool_button("Preview Spawn") var preview_button: Callable = _preview_spawn

var has_spawned: bool = false
var spawned_node: CanvasItem:
	set(value):
		
		spawned_node = value
		
		if not spawned and spawned_node:
			has_spawned = true

func despawn() -> void:
	
	if not spawned_node:
		return
	
	spawned_node.queue_free()
	spawned_node = null

func try_spawn(..._parameters: Array) -> void:
	
	if spawn_type == SpawnType.ONE_TIME and has_spawned:
		return
	
	spawn()
	spawned.emit()

@abstract
func _preview_spawn() -> void

static func is_valid_spawner(spawner: BaseSpawner) -> bool:
	
	if not spawner:
		return false
	
	if not spawner.scene:
		return false
	
	return true
