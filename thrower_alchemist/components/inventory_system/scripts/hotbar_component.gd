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
		GameDebugger.debug_log(HotbarComponent, "Changed item selected to = " + str(item_selected))

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
	
	GameDebugger.debug_log(HotbarComponent, "Item Getted: " + str(value) + "; in pos = " + str(pos))
	return value

func get_item_selected() -> InventoryItemInstance:
	return get_item(item_selected)

func set_item_selected(new_value: InventoryItemInstance) -> bool:
	return set_item(item_selected, new_value)

## Returns -1 when a position is not free
func get_first_free_position() -> int:
	
	for i: int in range(_items.size()):
		if not _items[i]:
			return i
	
	return -1

func add_item(pos: int, item: InventoryItemData, amount: int) -> bool:
	
	var getted: InventoryItemInstance = get_item(pos)
	
	if not getted:
		var instance: InventoryItemInstance = InventoryItemInstance.generate(item, amount)
		set_item(pos, instance)
		return true
	
	if getted.data != item:
		return false
	
	getted.amount += amount
	return true

func replace_item(pos: int, item: InventoryItemInstance) -> InventoryItemInstance:
	
	var getted: InventoryItemInstance = get_item(pos)
	
	if not getted:
		set_item(pos, item)
		return null
	
	if item:
		if getted.data == item.data:
			_items[pos].amount += item.amount
			return null
	
	set_item(pos, item)
	
	return getted

func set_item_data(pos: int, new_value: InventoryItemData) -> bool:
	
	var getted: InventoryItemInstance = get_item(pos)
	
	if getted:
		
		if getted.data == new_value:
			return false
	
	var instance: InventoryItemInstance = InventoryItemInstance.generate(new_value)
	set_item(pos, instance)
	
	return true

func set_item(pos: int, new_value: InventoryItemInstance) -> bool:
	
	_exists_position(pos)
	
	if get_item(pos) == new_value:
		return false
	
	_items.set(pos, new_value)
	item_setted.emit(pos, new_value)
	
	return true

func _exists_position(pos: int) -> bool:
	
	var status: bool = pos >= 0 and pos < spaces
	
	if crash_on_invalid_position:
		assert(status, "The position " + str(pos) + " don't exists!")
	
	return status
