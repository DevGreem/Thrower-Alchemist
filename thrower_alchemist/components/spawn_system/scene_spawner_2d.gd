@tool
extends BaseSpawner

class_name SceneSpawner2D

func spawn() -> void:
	
	GameDebugger.debug_log(SceneSpawner2D, "Spawning scene " + str(scene))
	
	spawned_node = scene.instantiate() as Node2D
	
	spawned_node.global_position = self.global_position
	
	EventBus.spawn_node(
		spawned_node,
		spawn_container,
		spawn_deferred
	)
	
	has_spawned = true

func _preview_spawn() -> void:
	
	var node: Node2D = scene.instantiate(PackedScene.GEN_EDIT_STATE_DISABLED)
	node.owner = null
	add_child(node)
