@abstract
@tool
extends Marker2D

class_name BaseSpawner

enum SpawnType {
	READY,
	VISIBLE,
	NO_VISIBLE,
	RESPAWN_VISIBLE,
	RESPAWN_NO_VISIBLE,
	NONE
}

enum DespawnType {
	NONE,
	FREE,
	VISIBLE,
	NO_VISIBLE
}

const NO_VISIBLE_TYPES: Array[SpawnType] = [
	SpawnType.READY,
	SpawnType.NONE
]

@export var spawn_on: SpawnType:
	set(value):
		spawn_on = value
		update_configuration_warnings()

@export var visible_node: VisibleOnScreenNotifier2D:
	set(value):
		visible_node = value
		update_configuration_warnings()

@export var despawn_on: SpawnType = SpawnType.NONE:
	set(value):
		despawn_on = value
		update_configuration_warnings()

@export var spawn_container: ContainerType.Enum = ContainerType.Enum.ENTITIES_CONTAINER

var spawned: bool = false
var spawned_node: CanvasItem:
	set(value):
		
		spawned_node = value
		
		if not spawned and spawned_node:
			spawned = true

func _ready() -> void:
	
	if Engine.is_editor_hint():
		return
	
	if spawn_on == SpawnType.READY:
		spawned = true
		spawn()
	
	if spawn_on in NO_VISIBLE_TYPES:
		return
	
	if not visible_node.screen_entered.is_connected(_on_screen_entered):
		visible_node.screen_entered.connect(_on_screen_entered)
	
	if not visible_node.screen_exited.is_connected(_on_screen_exited):
		visible_node.screen_exited.connect(_on_screen_exited)

@abstract
func spawn() -> void

func despawn() -> void:
	spawned_node.queue_free()
	spawned_node = null

func _on_screen_entered() -> void:
	
	if spawn_on == SpawnType.VISIBLE and not spawned:
		spawn()
	elif spawn_on == SpawnType.RESPAWN_VISIBLE and not spawned_node:
		spawn()
	elif despawn_on == SpawnType.VISIBLE and spawned_node:
		despawn()

func _on_screen_exited() -> void:
	
	if spawn_on == SpawnType.NO_VISIBLE and not spawned:
		spawn()
	elif spawn_on == SpawnType.RESPAWN_NO_VISIBLE and not spawned_node:
		spawn()
	elif despawn_on == SpawnType.NO_VISIBLE and spawned_node:
		despawn()

func _validate_property(property: Dictionary) -> void:
	
	if property.name == "visible_node":
		if spawn_on in NO_VISIBLE_TYPES and despawn_on in NO_VISIBLE_TYPES:
			property.usage = PROPERTY_USAGE_NO_EDITOR

func _get_configuration_warnings() -> PackedStringArray:
	
	var warnings: PackedStringArray = []
	
	if spawn_on == SpawnType.NONE:
		warnings.append("Scene never will be spawn")
	
	if spawn_on == despawn_on:
		warnings.append("spawn_on and despawn_on properties are equals")
	
	if spawn_on not in NO_VISIBLE_TYPES or despawn_on not in NO_VISIBLE_TYPES:
		
		if not visible_node:
			warnings.append("No VisibleOnScreenNotifier2D node assigned")
	
	if not spawn_container:
		warnings.append("No spawn container assigned")
	
	return warnings
