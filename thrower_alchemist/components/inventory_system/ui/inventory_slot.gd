@tool
extends Control

class_name InventorySlot

@export var content: InventorySlotContent
@export var selection_border: TextureRect

static func generate(scene: PackedScene, item: InventoryItemInstance) -> InventorySlot:
	
	var node: InventorySlot = scene.instantiate()
	
	if item and item.data:
		node.content.set_item(item.data)
	
	return node

func select() -> void:
	selection_border.visible = true

func unselect() -> void:
	selection_border.visible = false
