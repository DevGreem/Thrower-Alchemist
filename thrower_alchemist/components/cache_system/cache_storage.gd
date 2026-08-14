extends CacheComponent

class_name CacheStorage

func set_cache(...parameters: Array) -> bool:
	
	var size: int = parameters.size()
	
	if size < 2:
		return false
	
	var root: Dictionary = {}
	var current_key: Variant = root
	
	for i: int in range(size-1):
		
		var key: Variant = parameters[i]
		
		if not current_key.has(key):
			current_key[key] = {}
		
		current_key = current_key[key]
	
	current_key[parameters[-2]] = parameters[-1]
	
	return true

func clear_cache() -> void:
	cache.storage.clear()
	cache.cleared.emit()
