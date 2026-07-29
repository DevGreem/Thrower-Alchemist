@tool
extends PanelContainer

class_name InventorySlot

@export var icon: TextureRect
@export var label: Label

@export var const_size: Vector2:
	set(value):
		
		if const_size == value:
			return
		
		const_size = value

static func generate(scene: PackedScene, item: InventoryItemData) -> InventorySlot:
	
	var slot: InventorySlot = scene.instantiate()
	
	if item:
		
		if slot.label:
			slot.label.text = item.get_item_name()
			item.set_name_effect(slot.label)
		
		if slot.icon:
			slot.icon.texture = item.get_item_icon()
			item.set_icon_effect(slot.icon)
		
		slot.tooltip_text = item.get_tooltips_text()
	
	return slot

func _ready() -> void:
	self.custom_minimum_size = const_size
	self.custom_maximum_size = const_size
