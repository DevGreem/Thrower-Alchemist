@tool
extends HBoxContainer

class_name GraphicHotbar

@export var auto_detect_player_hotbar: bool = false
@export var hotbar_component: HotbarComponent
@export var default_slot_scene: PackedScene:
	set(value):
		
		if default_slot_scene == value:
			return
		
		default_slot_scene = value
		_init_slots()

var slots: Array[InventorySlot] = []
var threads: Array[Thread] = []

func _ready() -> void:
	
	if auto_detect_player_hotbar:
		pass
	
	_init_slots()
	
	if not hotbar_component.item_selected_changed.is_connected(_on_select_new_item):
		hotbar_component.item_selected_changed.connect(_on_select_new_item)

func _init_slots() -> void:
	
	if not default_slot_scene:
		return
	
	if not hotbar_component:
		return
	
	for i: int in range(hotbar_component.spaces):
		var item: InventoryItemInstance = hotbar_component.get_item(i)
		
		var slot: InventorySlot = InventorySlot.generate(default_slot_scene, item)
		
		slots.append(slot)
		add_child(slot)
	
	_on_select_new_item(-1, hotbar_component.item_selected)

func _on_select_new_item(before: int, after: int) -> void:
	
	if before != -1:
		slots[before].unselect()
	
	slots[after].select()
