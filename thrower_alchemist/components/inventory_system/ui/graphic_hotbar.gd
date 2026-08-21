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

var slots: Array[InventorySlot] = []
var threads: Array[Thread] = []

func _ready() -> void:
	
	if Engine.is_editor_hint():
		return
	
	if not PlayerManager.player_changed.is_connected(_on_player_changed):
		PlayerManager.player_changed.connect(_on_player_changed)
	
	if is_instance_valid(PlayerManager.current_player):
		_on_player_changed(PlayerManager.current_player)

func _on_player_changed(new: Node) -> void:
	
	if not new:
		return
	
	var new_hotbar: HotbarComponent = ComponentManager.get_component(new, HotbarComponent)
	
	if hotbar_component and new_hotbar != hotbar_component:
		_disconnect_hotbar()
	
	if not new_hotbar:
		_delete_slots()
		return
	
	hotbar_component = new_hotbar
	_connect_hotbar()
	_init_slots()

func _connect_hotbar() -> void:
	if not hotbar_component.item_selected_changed.is_connected(_on_select_new_item):
		hotbar_component.item_selected_changed.connect(_on_select_new_item)
	
	if not hotbar_component.item_setted.is_connected(_on_item_setted):
		hotbar_component.item_setted.connect(_on_item_setted)

func _disconnect_hotbar() -> void:
	if hotbar_component.item_selected_changed.is_connected(_on_select_new_item):
		hotbar_component.item_selected_changed.disconnect(_on_select_new_item)
	
	if hotbar_component.item_setted.is_connected(_on_item_setted):
		hotbar_component.item_setted.disconnect(_on_item_setted)

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

func _delete_slots() -> void:
	for child: Node in get_children():
		remove_child(child)

func _on_item_setted(pos: int, value: InventoryItemInstance) -> void:
	
	var data: InventoryItemData = null
	
	if value:
		data = value.data
	
	slots[pos].content.set_item(data)

func _on_select_new_item(before: int, after: int) -> void:
	
	if before != -1:
		slots[before].unselect()
	
	slots[after].select()
