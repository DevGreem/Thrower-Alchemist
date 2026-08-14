extends RefCounted

class_name Cache

@warning_ignore("unused_signal")
signal cleared

var storage: Dictionary = {}:
	set(value):
		
		storage = value
		
		if storage == {}:
			cleared.emit()

var getter_manager: CacheGetter:
	set = set_getter

var storage_manager: CacheStorage:
	set = set_storage

func set_getter(value: Variant) -> void:
	
	getter_manager = value
	
	if value:
		getter_manager.cache = self

func set_storage(value: Variant) -> void:
	storage_manager = value
	storage_manager.cache = self
