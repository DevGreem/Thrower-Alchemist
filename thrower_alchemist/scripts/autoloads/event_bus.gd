extends Node

signal node_spawned
signal node_despawned

func spawn_node(node: Node, container: Node, deferred: bool = false) -> bool:
	
	if not container:
		return false
	
	if node.get_parent() == container:
		return false
	
	_spawn(node, container, deferred)
	
	return true

func spawn_node_in_group(node: Node, group: ContainerType.Enum, deferred: bool = false) -> bool:
	
	var container: Node = _get_container(group)
	
	return spawn_node(node, container, deferred)

func despawn_node(node: Node) -> bool:
	
	if not is_instance_valid(node):
		return false
	
	node_despawned.emit(node)
	node.queue_free()
	
	return true

func spawn_scene(scene: PackedScene, container: Node, deferred: bool = false) -> Node:
	
	if not container:
		return null
	
	var node: Node2D = scene.instantiate()
	
	_spawn(node, container, deferred)
	
	return node

func spawn_scene_in_group(scene: PackedScene, group: ContainerType.Enum, deferred: bool = false) -> Node:
	
	var container: Node = _get_container(group)
	
	return spawn_scene(scene, container, deferred)

func _spawn(node: Node, container: Node, deferred: bool = false) -> void:
	
	if deferred:
		container.add_child.call_deferred(node)
	else:
		container.add_child(node)
	
	node_spawned.emit(node)

func _get_container(group: ContainerType.Enum) -> Node:
	return get_tree().get_first_node_in_group(ContainerType.as_string(group).to_snake_case())
