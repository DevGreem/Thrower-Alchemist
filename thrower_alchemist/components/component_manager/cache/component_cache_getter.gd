extends CacheGetter

class_name ComponentCacheGetter

func get_component_cache(node: Node, type: Variant) -> CacheStatus:
	
	if not _exists_type_cache(node, type):
		return CacheStatus.generate(false, null)
	
	var arr: Array[Node] = _get_from_storage(node, type)
	
	if arr.is_empty():
		return CacheStatus.generate(true, null)
	
	var component: Node = arr.front()
	
	return CacheStatus.generate(true, component)

func get_component_array_cache(node: Node, type: Variant) -> CacheStatus:
	
	if not _exists_type_cache(node, type):
		return CacheStatus.generate(false, null)
	
	var arr: Array[Node] = _get_from_storage(node, type)
	
	return CacheStatus.generate(true, arr)

func _exists_node_cache(node: Node, empty_as_exists: bool = false) -> bool:
	
	if not cache.storage.has(node):
		return false
	
	if cache.storage[node].is_empty() and not empty_as_exists:
		return false
	
	return true

func _exists_type_cache(node: Node, type: Variant, node_empty_as_exists: bool = false, empty_as_exists: bool = true) -> bool:
	
	if not _exists_node_cache(node, node_empty_as_exists):
		return false
	
	var dict: Dictionary[Variant, Array] = cache.storage[node]
	
	if not dict.has(type):
		return false
	
	if dict[type].is_empty() and not empty_as_exists:
		return false
	
	return true
