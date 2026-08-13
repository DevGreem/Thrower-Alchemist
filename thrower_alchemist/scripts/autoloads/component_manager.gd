extends Node

## Dictionary of nodes with a dictionary of components and references to that component
var _components_cache: Dictionary[Node, Dictionary] = {}

## [parameter type] must be a type
func get_component(node: Node, type: Variant, recursive: bool = false, internal: bool = false) -> Node:
	
	if not is_instance_valid(node):
		return null
	
	var cache: CacheStatus = _get_component_cache(node, type)
	
	if cache.is_cached:
		return cache.value as Node
	
	for child: Node in node.get_children(internal):
		if is_instance_of(child, type):
			_add_component_cache(node, type, child)
			return child
		
		if not recursive:
			continue
		
		var ans: Node =_recursive_get_component(node, child, type, internal)
		
		if ans:
			return ans
	
	_add_component_cache(node, type, null)
	return null

func _recursive_get_component(parent: Node, node: Node, type: Variant, internal: bool = false) -> Node:
	
	if not is_instance_valid(parent) or not is_instance_valid(node):
		return null
	
	var cache: CacheStatus = _get_component_cache(node, type)
	
	if cache.is_cached:
		return cache.value as Node
	
	for child: Node in node.get_children():
		
		if is_instance_of(child, type):
			_add_component_cache(parent, type, child)
			_add_component_cache(node, type, child)
			return child
		
		_recursive_get_component(parent, child, type, internal)
	
	_add_component_cache(node, type, null)
	return null

func get_component_array(node: Node, type: Array, internal: bool = false) -> Array[Node]:
	
	return []

## [parameter types] must be an array of types
func get_components(node: Node, types: Array, internal: bool = false) -> Dictionary[Variant, Node]:
	
	var answer: Dictionary[Variant, Node] = {}
	
	if not is_instance_valid(node) or types.is_empty():
		return answer
	
	for child: Node in node.get_children(internal):
		
		for type: Variant in types:
		
			if is_instance_of(child, type):
				_add_component_cache(node, type, child)
				answer.set(type, child)
	
	return answer

func clear_cache() -> void:
	_components_cache.clear()

func _add_component_cache(node: Node, type: Variant, component: Node) -> void:
	
	if not node.tree_exited.is_connected(_erase_node_cache.bind(node)):
		node.tree_exited.connect(_erase_node_cache.bind(node))
	
	if component:
		if not component.tree_exited.is_connected(_erase_component_cache.bind(node, type)):
			component.tree_exited.connect(_erase_component_cache.bind(node, type))
	
	if _components_cache.has(node):
		_components_cache[node].set(type, component)
		return
	
	_components_cache.set(node, {
		type: component
	})

func _erase_node_cache(node: Node) -> void:
	_components_cache.erase(node)

func _erase_component_cache(node: Node, type: Variant) -> void:
	
	if _components_cache.has(node):
		_components_cache[node].erase(type)

func _get_component_cache(node: Node, type: Variant) -> CacheStatus:
	
	if not _components_cache.has(node):
		return CacheStatus.generate(false, null)
	
	var cache_dict: Dictionary = _components_cache.get(node, {})
	
	if not cache_dict.has(type):
		return CacheStatus.generate(false, null)
	
	var component: Node = cache_dict.get(type)
	
	if not is_instance_valid(component) and component != null:
		return CacheStatus.generate(false, null)
	
	return CacheStatus.generate(true, component)
	
