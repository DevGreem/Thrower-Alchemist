extends Panel

class_name MixerSlot

signal pressed
signal removed

var potions_mixer: PotionsMixerNode
var idx: int = -1
@export var potion_icon: PotionIconComponent

func _gui_input(event: InputEvent) -> void:
	
	if idx == -1:
		return
	
	if event is InputEventMouseButton:
		
		if not event.pressed:
			return
		
		if event.button_index == MOUSE_BUTTON_LEFT:
			GameDebugger.debug_log(MixerSlot, "Clicked slot " + str(self))
			_on_pressed()
		
		if event.button_index == MOUSE_BUTTON_RIGHT:
			GameDebugger.debug_log(MixerSlot, "Right Clicked Slot " + str(self))
			_on_removed()

func _on_pressed() -> void:
	pressed.emit()
	var hotbar: HotbarComponent = _get_hotbar()
	
	var potion: InventoryItemInstance = InventoryItemInstance.generate(
		potions_mixer.get_potion_data(idx)
	)
	
	var replaced: InventoryItemInstance = hotbar.replace_item(hotbar.item_selected, potion)
	
	if replaced:
		potions_mixer.set_potion_data(idx, replaced.data as PotionData)
	else:
		potions_mixer.set_potion_data(idx, null)

func _on_removed() -> void:
	removed.emit()
	var hotbar: HotbarComponent = _get_hotbar()
	
	var free_position: int = hotbar.get_first_free_position()
	
	if free_position == -1:
		return
	
	var potion: PotionData = potions_mixer.get_potion_data(idx)
	
	var item: InventoryItemInstance = InventoryItemInstance.generate(potion)
	hotbar.set_item(free_position, item)
	potions_mixer.set_potion_data(idx, null)

func _get_hotbar() -> HotbarComponent:
	return ComponentManager.get_component(PlayerManager.current_player, HotbarComponent)
