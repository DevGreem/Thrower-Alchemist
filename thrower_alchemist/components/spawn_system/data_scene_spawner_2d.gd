@tool
extends SceneSpawner2D
class_name DataSceneSpawner2D

@export var property_name: StringName:
	set(value):
		property_name = value
		notify_property_list_changed()

@export var data: Variant

func spawn() -> void:
	super.spawn()
	spawned_node.set(property_name, data)

func _preview_spawn() -> void:
	var node: Node2D = scene.instantiate(PackedScene.GEN_EDIT_STATE_DISABLED)
	node.owner = null
	node.set(property_name, data)
	add_child(node)

func _validate_property(property: Dictionary) -> void:
	
	if not scene:
		return
	
	var instance: Node = scene.instantiate()
	
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
