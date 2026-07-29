@tool
extends Control

class_name InventorySlot

@export var content: InventorySlotContent
@export var selection_border: TextureRect

static func generate(scene: PackedScene, item: InventoryItemData) -> InventorySlot:
	
	var node: InventorySlot = scene.instantiate()
	node.content.set_item(item)
	
	return node

func select() -> void:
	selection_border.visible = true

func unselect() -> void:
	selection_border.visible = false
