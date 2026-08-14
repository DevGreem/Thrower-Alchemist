extends Node

## Dictionary of nodes with a dictionary of components and references to that component
## Example:
## [codeblock]
##	{
##		<ParentNode>: {
##			AnyType: [
##				<Node1>,
##				<Node2>
##			]
##		}
##	}
## [/codeblock]
var _cache: ComponentCacheManager = ComponentCacheManager.new(
	ComponentCacheGetter.new(),
	ComponentCacheStorage.new(),
	ComponentCacheGarbage.new()
)

## [param type] must be a type
func get_component(node: Node, type: Variant, recursive: bool = false, internal: bool = false) -> Node:
	
	if not is_instance_valid(node):
		return null
	
	var cache: CacheStatusNode = _cache.getter_manager().get_component_cache(node, type)
	
	if cache.is_cached:
		return cache.get_value()
	
	for child: Node in node.get_children(internal):
		if is_instance_of(child, type):
			#_add_component_cache(node, type, child)
			return child
		
		if not recursive:
			continue
		
		var ans: Node = recursive_get_component(node, child, type, internal)
		
		if ans:
			return ans
	
	#_add_component_cache(node, type, null)
	return null

func recursive_get_component(parent: Node, node: Node, type: Variant, internal: bool = false) -> Node:
	
	if not is_instance_valid(parent) or not is_instance_valid(node):
		return null
	
	var cache: CacheStatusNode = _cache.getter_manager().get_component_cache(node, type)
	
	if cache.is_cached:
		return cache.get_value()
	
	for child: Node in node.get_children():
		
		if is_instance_of(child, type):
			#_add_component_cache(parent, type, child)
			#_add_component_cache(node, type, child)
			return child
		
		var ans: Node = recursive_get_component(parent, child, type, internal)
		
		if ans:
			#_add_component_cache(parent, type, child)
			#_add_component_cache(node, type, child)
			return ans
	
	#_add_component_cache(node, type, null)
	return null

func get_component_array(node: Node, type: Array, recursive: bool = false, internal: bool = false) -> Array[Node]:
	
	if not is_instance_valid(node):
		return []
	
	var result: Array = []
	
	
	return []

## [parameter types] must be an array of types
func get_components(node: Node, types: Array, internal: bool = false) -> Dictionary[Variant, Node]:
	
	var answer: Dictionary[Variant, Node] = {}
	
	if not is_instance_valid(node) or types.is_empty():
		return answer
	
	for child: Node in node.get_children(internal):
		
		for type: Variant in types:
		
			if is_instance_of(child, type):
				#_add_component_cache(node, type, child)
				answer.set(type, child)
	
	return answer
