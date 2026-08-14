extends CacheComponent

class_name CacheGetter

func get_cache(...parameters: Array) -> Variant:
	
	if parameters.is_empty():
		return null
	
	var value: Variant = cache.storage[parameters[0]]
	
	for new_value: Variant in parameters:
		value = value[new_value]
	
	return value
