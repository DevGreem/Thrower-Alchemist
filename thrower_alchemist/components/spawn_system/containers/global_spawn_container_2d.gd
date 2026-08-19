extends Node2D

class_name GlobalSpawnContainer2D

signal node_spawned
signal node_despawned

@export var type: ContainerType.Enum

func _ready() -> void:
	SpawnManager2D.register_container(self)

func spawn_node(node: Node, deferred: bool = false) -> Node:
	
	if not is_instance_valid(node):
		return null
	
	if deferred:
		add_child.call_deferred(node)
	else:
		add_child(node)
	
	node_spawned.emit(node)
	
	return node

func spawn_scene(scene: PackedScene, global_pos: Vector2, deferred: bool = false) -> Node:
	
	var instance: Node = scene.instantiate()
	
	return spawn_node(instance, deferred)

func despawn_node(node: Node, deferred: bool = false) -> bool:
	
	if not is_instance_valid(node):
		return false
	
	if deferred:
		remove_child.call_deferred(node)
	else:
		remove_child(node)
	
	node_despawned.emit()
	return true

func _exit_tree() -> void:
	SpawnManager2D.unregister_container(self.type)
