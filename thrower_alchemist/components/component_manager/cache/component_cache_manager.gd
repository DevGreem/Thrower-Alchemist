extends CacheManager

class_name ComponentCacheManager

func get_getter_manager() -> ComponentCacheGetter:
	return getter_manager

func get_storage_manager() -> ComponentCacheStorage:
	return storage_manager

func get_garbage_manager() -> ComponentCacheGarbage:
	return garbage_manager
