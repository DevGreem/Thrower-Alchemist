extends Node

class_name TagsComponent

@export var tags: Array[TagData] = []

## Dictionary of types of TagData and bools
var _tag_cache: Dictionary[Variant, bool] = {}

## [parameter tag_type] tag_type is a type of TagData
func has_tag(tag_type: Variant) -> bool:
	
	var cache: CacheStatus = _get_tag_cache(tag_type)
	
	if cache.is_cached:
		return cache.value
	
	for tag: TagData in tags:
		if is_instance_of(tag, tag_type):
			_tag_cache[tag_type] = true
			return true
	
	_tag_cache[tag_type] = false
	
	return false

func _get_tag_cache(tag: Variant) -> CacheStatus:
	
	if _tag_cache.has(tag):
		return CacheStatus.generate(true, _tag_cache[tag])
	
	return CacheStatus.generate(false, null)
