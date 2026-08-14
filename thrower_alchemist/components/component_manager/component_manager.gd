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
var _components_cache: Dictionary[Node, Dictionary] = {}
var _cache: ComponentCacheManager = ComponentCacheManager.new(
	ComponentCacheGetter.new(),
	ComponentCacheStorage.new(),
	ComponentCacheGarbage.new()
)

## [param type] must be a type
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
		
		var ans: Node = recursive_get_component(node, child, type, internal)
		
		if ans:
			return ans
	
	_add_component_cache(node, type, null)
	return null

func recursive_get_component(parent: Node, node: Node, type: Variant, internal: bool = false) -> Node:
	
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
		
		var ans: Node = recursive_get_component(parent, child, type, internal)
		
		if ans:
			_add_component_cache(parent, type, child)
			_add_component_cache(node, type, child)
			return ans
	
	_add_component_cache(node, type, null)
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
				_add_component_cache(node, type, child)
				answer.set(type, child)
	
	return answer

func clear_cache() -> void:
	_components_cache.clear()

func clear_type(node: Node, type: Variant) -> bool:
	
	if not _components_cache.has(node):
		return false
	
	if not _components_cache[node].has(type):
		return false
	
	_components_cache[node][type].clear()
	return true

func _add_component_cache(node: Node, type: Variant, component: Node) -> void:
	
	if not is_instance_valid(node) or not is_instance_valid(component):
		return
	
	if not node.tree_exiting.is_connected(erase_node_cache.bind(node)):
		node.tree_exiting.connect(erase_node_cache.bind(node))
	
	if not _components_cache.has(node):
		_components_cache[node] = {}
	
	if not _components_cache[node].has(type):
		_components_cache[node][type] = [component]
	else:
		_components_cache[node][type].append(component)
	
	var idx: int = _components_cache[node][type].size()
	
	if not component.tree_exiting.is_connected(erase_component_cache.bind(node, type, idx)):
		component.tree_exiting.connect(erase_component_cache.bind(node, type, idx))

func erase_node_cache(node: Node) -> void:
	_components_cache.erase(node)

func erase_type_cache(node: Node, type: Variant) -> bool:
	
	if _components_cache.has(node):
		return _components_cache[node].erase(type)
	
	return false

func erase_component_cache(node: Node, type: Variant, idx: int) -> bool:
	
	if not _components_cache.has(node):
		return false
	
	if not _components_cache[node].has(type):
		return false
	
	_components_cache[node][type].remove_at(idx)
	return true

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
	
