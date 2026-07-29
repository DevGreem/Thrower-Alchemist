extends InputComponent

class_name UseItemInput

@export var hotbar_component: HotbarComponent

func _input(event: InputEvent) -> void:
	
	if not active:
		return
	
	if event.is_action("use"):
		var item: InventoryItemData = hotbar_component.get_item_selected()
		
		if item:
			item.use(actor)
