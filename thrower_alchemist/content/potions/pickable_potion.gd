@tool
extends StaticPotionNode

class_name PickablePotion

@export var interact_area: InteractArea2D

func _ready() -> void:
	
	if not interact_area.interacted.is_connected(_on_interact):
		interact_area.interacted.connect(_on_interact)

func _on_interact(component: InteractComponent2D) -> void:
	
	GameDebugger.debug_log(PickablePotion, "Picked potion")
	
	if not data:
		GameDebugger.debug_error(PickablePotion, "Data no founded")
		return
	
	var hotbar: HotbarComponent = ComponentManager.get_component(component.actor, HotbarComponent)
	
	if not hotbar:
		GameDebugger.debug_log(PickablePotion, "Hotbar not founded")
		return
	
	var free_pos: int = hotbar.get_first_free_position()
	
	if free_pos == -1:
		
		var instance: InventoryItemInstance = InventoryItemInstance.generate(
			self.data
		)
		
		hotbar.replace_item(hotbar.item_selected, instance)
	else:
		hotbar.add_item(free_pos, self.data, 1)
	
	self.queue_free()
