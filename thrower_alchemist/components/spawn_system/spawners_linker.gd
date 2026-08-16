@tool
extends Node

class_name SpawnersLinker

@export var spawner: BaseSpawner:
	set(value):
		spawner = value
		notify_property_list_changed()

@export var signal_to_connect: StringName

@export var target_spawner: BaseSpawner:
	set(value):
		target_spawner = value
		notify_property_list_changed()

@export var method_to_connect: StringName

func _ready() -> void:
	
	if Engine.is_editor_hint():
		return
	
	if not BaseSpawner.is_valid_spawner(spawner):
		GameDebugger.debug_error(SpawnersLinker, "Main Spawner not is valid")
		return
	
	if not BaseSpawner.is_valid_spawner(target_spawner):
		GameDebugger.debug_error(SpawnersLinker, "Target Spawner not is valid")
		return
	
	if not spawner.spawned.is_connected(_on_spawn):
		spawner.spawned.connect(_on_spawn)
	
	if not spawner.spawned.is_connected(_on_spawn):
		spawner.spawned.connect(_on_spawn)
	

func _on_spawn() -> void:
	
	if not spawner.spawned_node or not target_spawner.spawned_node:
		return
	
	spawner.spawned_node.connect(
		signal_to_connect,
		Callable(target_spawner, method_to_connect)
	)

func _validate_property(property: Dictionary) -> void:
	
	if property.name == "signal_to_connect":
		_get_spawner_signals(property)
	
	if property.name == "method_to_connect":
		_get_target_methods(property)

func _get_target_methods(property: Dictionary) -> void:
	
	if not BaseSpawner.is_valid_spawner(target_spawner):
		return
	
	var node: Node = target_spawner.scene.instantiate()
	
	var methods: Array = _get_names(node.get_method_list())
	
	property.hint = PROPERTY_HINT_ENUM
	property.hint_string = ",".join(methods)
	
func _get_spawner_signals(property: Dictionary) -> void:
	
	if not BaseSpawner.is_valid_spawner(spawner):
		return
	
	var node: Node = spawner.scene.instantiate()
	
	var signals: Array = _get_names(node.get_signal_list())
	
	property.hint = PROPERTY_HINT_ENUM
	property.hint_string = ",".join(signals)

func _get_names(arr: Array[Dictionary]) -> Array:
	return arr.map(
		func(val: Dictionary) -> StringName:
			return val.name
	)
