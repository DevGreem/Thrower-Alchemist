@tool
extends BaseSpawner

class_name SceneSpawner2D

@export var scene: PackedScene:
	set(value):
		scene = value
		notify_property_list_changed()
		update_configuration_warnings()

func spawn() -> void:
	
	GameDebugger.debug_log(SceneSpawner2D, "Spawning scene " + str(scene))
	spawned_node = EventBus.spawn_scene(
		scene,
		self.global_position,
		spawn_container
	)
	
	has_spawned = true

func _preview_spawn() -> void:
	
	var node: Node2D = scene.instantiate(PackedScene.GEN_EDIT_STATE_DISABLED)
	node.owner = null
	add_child(node)
