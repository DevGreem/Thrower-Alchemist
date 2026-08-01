extends Node

## Dictionary of nodes with a dictionary of components and references to that component
var _components_cache: Dictionary[Node, Dictionary] = {}

## [parameter type] must be a type
func get_component(node: Node, type: Variant) -> Node:
	
	var cache: CacheStatus = _get_component_cache(node, type)
	
	if cache.is_cached:
		return cache.value as Node
	
	for child: Node in node.get_children():
		if is_instance_of(child, type):
			_add_component_cache(node, type, child)
			return child
	
	_add_component_cache(node, type, null)
	return null

## [parameter types] must be an array of types
func get_components(node: Node, types: Array) -> Dictionary[Variant, Node]:
	
	var answer: Dictionary[Variant, Node] = {}
	
	for child: Node in node.get_children():
		
		for type: Variant in types:
		
			if is_instance_of(child, type):
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
	var cache_dict: Dictionary = _components_cache.get(node, {})
	
	if cache_dict:
		var component: Node = cache_dict.get(type)
		return CacheStatus.generate(true, component)
	
	return CacheStatus.generate(false, null)
