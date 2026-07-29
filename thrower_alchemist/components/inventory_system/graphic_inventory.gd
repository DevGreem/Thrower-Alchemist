extends ItemList

class_name GraphicInventory

@export var inventory_component: InventoryComponent:
	set(value):
		
		if inventory_component == value:
			return
		
		_on_unset_inventory()
		inventory_component = value
		_on_set_inventory_component()

func _on_unset_inventory() -> void:
	
	if not inventory_component or not is_instance_valid(inventory_component):
		return
	
	for curr_signal: Dictionary in inventory_component.get_signal_list():
		
		var sign_name: String = curr_signal.name
		var function: Callable = Callable(self, str("_on_", sign_name))
		
		if inventory_component.is_connected(sign_name, function):
			inventory_component.disconnect(
				sign_name,
				function
			)

func _on_set_inventory_component() -> void:
	
	if not inventory_component:
		return
	
	self.max_columns = inventory_component.columns
	
	if not inventory_component.item_added.is_connected(_on_item_added):
		inventory_component.item_added.connect(_on_item_added)
	
	if not inventory_component.item_removed.is_connected(_on_item_removed):
		inventory_component.item_removed.connect(_on_item_removed)
	
	if not inventory_component.item_setted.is_connected(_on_item_setted):
		inventory_component.item_setted.connect(_on_item_setted)

#TODO: Make a custom Grid Control for UI
func _on_item_added(_pos: Vector2, _value: Resource) -> void:
	
	var placeholder: PlaceholderTexture2D = PlaceholderTexture2D.new()
	placeholder.size = Vector2(8, 8)
	self.add_item("", placeholder)

func _on_item_removed(pos: Vector2) -> void:
	#self.remove_item(pos)
	pass

func _on_item_setted(pos: Vector2, value: Resource) -> void:
	pass
