extends InputComponent

class_name InteractItemInput

@export var hotbar_component: HotbarComponent

func _input(event: InputEvent) -> void:
	
	if event.is_action_pressed("interact"):
		var item: InventoryItemInstance = hotbar_component.get_item_selected()
		
		if item:
			item.data.interact(actor)
