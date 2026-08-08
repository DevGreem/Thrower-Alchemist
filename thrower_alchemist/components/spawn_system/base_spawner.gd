@abstract
@tool
extends Marker2D

class_name BaseSpawner

signal spawned

enum SpawnType {
	ONE_TIME,
	RESPAWN
}

@export var spawn_type: SpawnType:
	set(value):
		spawn_type = value
		update_configuration_warnings()
		notify_property_list_changed()

@export var spawn_container: ContainerType.Enum = ContainerType.Enum.ENTITIES_CONTAINER

@export_tool_button("Preview Spawn") var preview_button: Callable = _preview_spawn

var has_spawned: bool = false
var spawned_node: CanvasItem:
	set(value):
		
		spawned_node = value
		
		if not spawned and spawned_node:
			has_spawned = true

func _ready() -> void:
	
	if Engine.is_editor_hint():
		return

@abstract
func spawn() -> void

func despawn() -> void:
	
	if not spawned_node:
		return
	
	spawned_node.queue_free()
	spawned_node = null

func try_spawn(..._parameters: Array) -> void:
	
	if spawn_type == SpawnType.ONE_TIME and has_spawned:
		return
	
	spawn()
	has_spawned = true

@abstract
func _preview_spawn() -> void

func _get_configuration_warnings() -> PackedStringArray:
	
	var warnings: PackedStringArray = []
	
	if not spawn_container:
		warnings.append("No spawn container assigned")
	
	return warnings
