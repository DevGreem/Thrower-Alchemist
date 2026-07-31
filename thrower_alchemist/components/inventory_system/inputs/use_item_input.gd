extends InputComponent

class_name UseItemInput

@export var hotbar_component: HotbarComponent

func _input(event: InputEvent) -> void:
	
	if not active:
		return
	
	if event.is_action_pressed("use"):
		var item: InventoryItemInstance = hotbar_component.get_item_selected()
		
		if item:
			item.use(actor)

func _use_item(item: InventoryItemData) -> void:
	
	if not item:
		return
	
