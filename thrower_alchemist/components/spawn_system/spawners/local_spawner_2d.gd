@tool
extends BaseSpawner

class_name LocalSpawner2D

@export var spawn_container: LocalSpawnContainer2D

func _preview_spawn() -> void:
	pass

func spawn() -> void:
	
	GameDebugger.debug_log(LocalSpawner2D, "Spawning scene " + str(scene))
	
	spawned_node = scene.instantiate() as Node2D
	
	spawned_node.global_position = self.global_position
	
	spawn_container.spawn_node(spawned_node, spawn_deferred)
