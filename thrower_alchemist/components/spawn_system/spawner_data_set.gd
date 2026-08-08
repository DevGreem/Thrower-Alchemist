@tool
extends Node

class_name SpawnerDataSet

@export var spawner: BaseSpawner:
	set = _on_set_spawner

@export var property_name: StringName:
	set(value):
		property_name = value
		notify_property_list_changed()

@export var data: Variant

func _ready() -> void:
	pass

func _on_set_spawner(value: BaseSpawner) -> void:
	
	if spawner == value:
		return
	
	if BaseSpawner.is_valid_spawner(spawner):
		
		if spawner.spawned.is_connected(_on_spawn):
			spawner.spawned.disconnect(_on_spawn)
	
	spawner = value
	
	if not BaseSpawner.is_valid_spawner(spawner):
		return
	
	if not spawner.spawned.is_connected(_on_spawn):
		spawner.spawned.connect(_on_spawn)

func _on_spawn() -> void:
	spawner.spawned_node.set(property_name, data)

func _validate_property(property: Dictionary) -> void:
	
	if not BaseSpawner.is_valid_spawner(spawner):
		return
	
	var instance: Node = spawner.scene.instantiate()
	
	if property.name == "property_name":
		
		var names: Array =  instance.get_property_list().map(
			func(val: Dictionary) -> String:
				return val.name
		)
		
		property.hint = PROPERTY_HINT_ENUM
		property.hint_string = ",".join(names)
	
	elif property.name == "data" and property_name:
		_get_prop_type(instance, property)
	
	instance.free()

func _get_prop_type(instance: Object, _prop: Dictionary) -> void:
	
	for prop: Dictionary in instance.get_property_list():
		
		if not prop.name == _prop.name:
			continue
		
		_prop.type = prop.type
		_prop.hint = prop.hint
		_prop.hint_string = prop.hint_string
		return
	
	return
