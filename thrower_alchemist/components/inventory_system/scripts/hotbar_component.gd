@tool
extends BaseInventoryComponent

class_name HotbarComponent

signal item_selected_changed(before: int, after: int)

@export var spaces: int = 1:
	set(value):
		
		if spaces == value:
			return
		
		if value < 1:
			value = 1
		
		spaces = value

@export var _items: Array[InventoryItemData] = []
@export var item_selected: int = 0:
	set(value):
		
		_exists_position(value)
		
		if item_selected == value:
			return
		
		item_selected_changed.emit(item_selected, value)
		item_selected = clampi(value, 0, spaces-1)

func _ready() -> void:
	
	if _items.size() < spaces-1:
		for i: int in range(spaces-_items.size()+1):
			_items.append(null)
	
	if _items.size() > spaces:
		for i: int in range(_items.size() - spaces):
			_items.remove_at(-1)

func get_item(pos: int) -> InventoryItemData:
	var value: InventoryItemData = _items.get(pos)
	item_getted.emit(pos, value)
	return value

func set_item(pos: int, new_value: InventoryItemData) -> bool:
	
	_exists_position(pos)
	
	if _items[pos] == new_value:
		return false
	
	_items.set(pos, new_value)
	item_setted.emit(pos, new_value)
	
	return true

func _exists_position(pos: int) -> void:
	assert(pos >= 0 and pos < spaces, "The position " + str(pos) + " don't exists!")
