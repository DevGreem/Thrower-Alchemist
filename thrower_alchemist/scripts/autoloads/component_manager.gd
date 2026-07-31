extends Node

## [parameter type] must be a type
func get_component(node: Node, type: Variant) -> Node:
	
	for child: Node in node.get_children():
		if is_instance_of(child, type):
			return child
	
	return null

## [parameter types] must be an array of types
func get_components(node: Node, types: Array) -> Dictionary[Variant, Node]:
	
	var answer: Dictionary[Variant, Node] = {}
	
	for child: Node in node.get_children():
		
		for type: Variant in types:
		
			if is_instance_of(child, type):
				answer.set(type, child)
	
	return answer
