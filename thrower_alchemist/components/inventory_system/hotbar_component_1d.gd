extends BaseInventoryComponent

class_name HotbarComponent

@export var spaces: int = 1

@export var _items: Array[Resource] = []

func _ready() -> void:
	
	if _items.size() < spaces-1:
		for i: int in range(spaces-_items.size()):
			_items.append(null)
	
	if _items.size() >= spaces:
		for i: int in range(_items.size() - spaces + 1):
			_items.remove_at(-1)

func get_item(pos: int) -> Resource:
	var value: Resource = _items.get(pos)
	item_getted.emit(pos, value)
	return value

func set_item(pos: int, new_value: Resource) -> bool:
	
	_exists_position(pos)
	
	if _items[pos] == new_value:
		return false
	
	_items.set(pos, new_value)
	item_setted.emit(pos, new_value)
	
	return true

func _exists_position(pos: int) -> void:
	assert(pos >= 0 and pos < spaces, "The position " + str(pos) + " don't exists!")
