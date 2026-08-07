@tool
extends Marker2D

class_name SceneSpawner2D

enum SpawnType {
	READY,
	VISIBLE,
	NO_VISIBLE,
	RESPAWN_VISIBLE,
	RESPAWN_NO_VISIBLE,
	NONE
}

const NO_VISIBLE_TYPES: Array[SpawnType] = [
	SpawnType.READY,
	SpawnType.NONE
]

@export var scene: PackedScene
@export var spawn_on: SpawnType

@export var visible_node: VisibleOnScreenNotifier2D

@export var despawn_on: SpawnType = SpawnType.NONE
@export var spawn_container: ContainerType.Enum = ContainerType.Enum.ENTITIES_CONTAINER

var spawned: bool = false
var spawned_node: CanvasItem

func _ready() -> void:
	
	if spawn_on == SpawnType.READY:
		spawned = true
		spawned_node = EventBus.spawn_scene(
			scene,
			self.global_position,
			spawn_container
		)
	
	if spawn_on in NO_VISIBLE_TYPES:
		return
	
	if not visible_node.screen_entered.is_connected(_on_screen_entered):
		visible_node.screen_entered.connect(_on_screen_entered)
	
	if not visible_node.screen_exited.is_connected(_on_screen_exited):
		visible_node.screen_exited.connect(_on_screen_exited)

func spawn() -> void:
	spawned_node = EventBus.spawn_scene(
		scene,
		self.global_position,
		spawn_container
	)

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
	
	return warnings
