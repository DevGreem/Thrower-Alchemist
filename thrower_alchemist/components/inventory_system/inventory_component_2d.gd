extends BaseInventoryComponent

class_name InventoryComponent

signal item_added(pos: Variant, value: Resource)
signal item_removed(pos: Variant, value: Resource)

@export var rows: int = 1
@export var columns: int = 1

@export var _items: Dictionary[Vector2, Resource] = {}

func get_item(pos: Vector2, default: Resource = null) -> Resource:
	
	var value: Resource = _items.get(pos, default)
	
	item_getted.emit(pos, value)
	return value
	
func add_item(pos: Vector2, value: Resource) -> bool:
	
	_exists_position(pos)
	var status: bool = _items.set(pos, value)
	
	if status:
		item_added.emit()
		return true
	
	return false

func remove_item(pos: Vector2) -> bool:
	_exists_position(pos)
	var status: bool = _items.erase(pos)
	
	if status:
		item_removed.emit()
		return true
	
	return false

func _exists_position(pos: Vector2) -> void:
	
	assert(pos.x >= 0 and pos.x < columns, "The x index don't exists!")
	assert(pos.y >= 0 and pos.y < rows, "The y index don't exists!")
