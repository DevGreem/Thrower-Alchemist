extends Node

signal node_spawned
signal node_despawned

func spawn_node(node: Node, group: ContainerType.Enum) -> bool:
	
	var container: Node = _get_container(group)
	
	if not container:
		return false
	
	if node.get_parent() == container:
		return false
	
	container.add_child(node)
	node_spawned.emit(node)
	
	return true

func despawn_node(node: Node) -> bool:
	
	if not is_instance_valid(node):
		return false
	
	node_despawned.emit(node)
	node.queue_free()
	
	return true

func spawn_scene(scene: PackedScene, pos: Vector2, group: ContainerType.Enum) -> Node:
	
	var container: Node = _get_container(group)
	
	if not container:
		return null
	
	var node: Node2D = scene.instantiate()
	node.global_pos = pos
	
	container.add_child(node)
	node_spawned.emit(node)
	
	return node

func _get_container(group: ContainerType.Enum) -> Node:
	return get_tree().get_first_node_in_group(ContainerType.as_string(group).to_snake_case())
