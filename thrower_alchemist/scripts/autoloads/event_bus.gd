extends Node

func spawn_node(node: Node, group: ContainerType.Enum) -> bool:
	
	var container: Node = _get_container(group)
	
	if not container:
		return false
	
	container.add_child(node)
	return true

func spawn_scene(scene: PackedScene, pos: Vector2, group: ContainerType.Enum) -> Node:
	
	var container: Node = _get_container(group)
	
	if not container:
		return null
	
	var node: Node2D = scene.instantiate()
	node.global_pos = pos
	
	container.add_child(node)
	return node

func _get_container(group: ContainerType.Enum) -> Node:
	return get_tree().get_first_node_in_group(ContainerType.as_string(group).to_snake_case())
