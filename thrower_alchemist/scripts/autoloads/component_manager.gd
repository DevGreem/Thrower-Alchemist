extends Node

func get_component(node: Node, type: Script) -> Node:
	
	for child: Node in node.get_children():
		if is_instance_of(child, type):
			return child
	
	return null
