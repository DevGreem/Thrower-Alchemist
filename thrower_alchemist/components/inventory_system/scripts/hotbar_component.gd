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

@export var _items: Array[InventoryItemInstance] = []
@export var item_selected: int = 0:
	set(value):
		
		_exists_position(value)
		
		if item_selected == value or value >= spaces or value < 0:
			return
		
		item_selected_changed.emit(item_selected, value)
		item_selected = value

@export var crash_on_invalid_position: bool = false

func _ready() -> void:
	
	if _items.size() < spaces-1:
		for i: int in range(spaces-_items.size()+1):
			_items.append(null)
	
	if _items.size() > spaces:
		for i: int in range(_items.size() - spaces):
			_items.remove_at(-1)

func _process(delta: float) -> void:
	
	for item: InventoryItemInstance in _items:
		
		if not item:
			continue
		
		if item.remaining_cooldown == -1:
			continue
		
		item.remaining_cooldown -= delta

func get_item(pos: int) -> InventoryItemInstance:
	var value: InventoryItemInstance = _items.get(pos)
	item_getted.emit(pos, value)
	return value

func get_item_selected() -> InventoryItemInstance:
	return get_item(item_selected)

func set_item(pos: int, new_value: InventoryItemInstance) -> bool:
	
	_exists_position(pos)
	
	if _items[pos] == new_value:
		return false
	
	_items.set(pos, new_value)
	item_setted.emit(pos, new_value)
	
	return true

func _exists_position(pos: int) -> bool:
	
	var status: bool = pos >= 0 and pos < spaces
	
	if crash_on_invalid_position:
		assert(status, "The position " + str(pos) + " don't exists!")
	
	return status
	
