@tool
extends PanelContainer

class_name InventorySlotContent

@export var icon: TextureRect
@export var label: Label

@export var const_size: Vector2:
	set(value):
		
		if const_size == value:
			return
		
		const_size = value

static func generate(scene: PackedScene, item: InventoryItemData) -> InventorySlotContent:
	
	var slot: InventorySlotContent = scene.instantiate()
	
	slot.set_item(item)
	
	return slot

func _ready() -> void:
	self.custom_minimum_size = const_size
	self.custom_maximum_size = const_size

func set_item(item: InventoryItemData) -> void:
	set_label(item)
	set_icon(item)
	
	if item:
		self.tooltip_text = item.get_tooltips_text()

func set_label(item: InventoryItemData) -> void:
	
	if not label:
		return
	
	if not item:
		self.label.text = ""
		return
	
	self.label.text = item.get_item_name()
	item.set_name_effect(self.label)

func set_icon(item: InventoryItemData) -> void:
	
	if not self.icon:
		return
	
	if not item:
		self.icon.texture = null
		return
	
	self.icon.texture = item.icon
	item.set_icon_effect(self.icon)
