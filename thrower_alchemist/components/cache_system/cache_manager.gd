extends RefCounted

class_name CacheManager

@warning_ignore("unused_signal")
signal cleared

var storage: Dictionary = {}:
	set(value):
		
		storage = value
		
		if storage == {}:
			cleared.emit()

var getter_manager: CacheGetter:
	get = get_getter_manager,
	set = set_getter

var storage_manager: CacheStorage:
	get = get_storage_manager,
	set = set_storage

var garbage_manager: CacheGarbage:
	get = get_garbage_manager,
	set = set_garbage

func _init(
	getter: CacheGetter = CacheGetter.new(),
	storager: CacheStorage = CacheStorage.new(),
	garbager: CacheGarbage = CacheGarbage.new()
) -> void:
	getter_manager = getter
	storage_manager = storager
	garbage_manager = garbager

func get_getter_manager() -> CacheGetter:
	return getter_manager

func get_storage_manager() -> CacheStorage:
	return storage_manager

func get_garbage_manager() -> CacheGarbage:
	return garbage_manager

func set_getter(value: CacheGetter) -> void:
	
	getter_manager = value
	
	if getter_manager:
		getter_manager.cache = self

func set_storage(value: CacheStorage) -> void:
	storage_manager = value
	
	if storage_manager:
		storage_manager.cache = self

func set_garbage(value: CacheGarbage) -> void:
	garbage_manager = value
	
	if garbage_manager:
		garbage_manager.cache = self
