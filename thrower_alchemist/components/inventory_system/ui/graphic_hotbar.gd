@tool
extends HBoxContainer

class_name GraphicHotbar

@export var hotbar_component: HotbarComponent
@export var default_slot_scene: PackedScene:
	set(value):
		
		if default_slot_scene == value:
			return
		
		default_slot_scene = value
		_init_slots()

func _ready() -> void:
	
	_init_slots()

func _init_slots() -> void:
	
	if not default_slot_scene:
		return
	
	if not hotbar_component:
		return
	
	for i: int in range(hotbar_component.spaces):
		var item: InventoryItemData = hotbar_component.get_item(i)
		
		var slot: InventorySlot = InventorySlot.generate(default_slot_scene, item)
		
		add_child(slot)
