@tool
extends BaseSpawner

class_name SceneSpawner2D

func spawn() -> void:
	
	GameDebugger.debug_log(SceneSpawner2D, "Spawning scene " + str(scene))
	spawned_node = EventBus.spawn_scene(
		scene,
		spawn_container
	)
	
	if spawned_node is Node2D:
		spawned_node.global_position = self.global_position
	
	has_spawned = true

func _preview_spawn() -> void:
	
	var node: Node2D = scene.instantiate(PackedScene.GEN_EDIT_STATE_DISABLED)
	node.owner = null
	add_child(node)
