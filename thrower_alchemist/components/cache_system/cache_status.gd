extends RefCounted

class_name CacheStatus

var is_cached: bool
var value: Variant

static func generate(_is_cached: bool, _value: Variant) -> CacheStatus:
	
	var status: CacheStatus = CacheStatus.new()
	status.is_cached = _is_cached
	status.value = _value
	
	return status
