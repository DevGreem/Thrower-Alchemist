@tool
extends BaseSpawner

class_name GlobalSpawner2D

@export var container_type: ContainerType.Enum

func _preview_spawn() -> void:
	
	if not scene:
		return
	
	var node: Node2D = scene.instantiate()
	
	if not node:
		return
	
	node.global_position = self.global_position
	add_child(node, false, Node.INTERNAL_MODE_BACK)
	
	return

func spawn() -> void:
	
	GameDebugger.debug_log(GlobalSpawner2D, "Spawning scene " + str(scene))
	
	spawned_node = scene.instantiate()
	
	spawned_node.global_position = self.global_position
	
	var container: GlobalSpawnContainer2D = SpawnManager2D.get_container(container_type)
	
	if not container:
		GameDebugger.debug_error(GlobalSpawner2D, "Container not exists")
		return
	
	container.spawn_node(spawned_node, spawn_deferred)
