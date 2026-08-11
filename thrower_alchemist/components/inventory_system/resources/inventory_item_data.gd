@tool
@abstract
extends ShareableResource

class_name InventoryItemData

@export var _ID: String
var id: String:
	get: return _ID

@export var icon: Texture2D
@export var name: String
@export_multiline var description: String
@export var cooldown: float = -1
@export var start_without_cooldown: bool = true
@export var max_stack: int = 1
@export var actions: ItemActions

func get_item_name() -> String:
	return self.name

@warning_ignore("unused_parameter")
func set_name_effect(node: Label) -> void:
	return

func get_item_icon() -> Texture2D:
	return self.icon

@warning_ignore("unused_parameter")
func set_icon_effect(node: TextureRect) -> void:
	return

func get_tooltips() -> PackedStringArray:
	return []

func get_tooltips_text() -> String:
	var lines: PackedStringArray = get_tooltips()
	return join_method(lines)

func join_method(lines: PackedStringArray) -> String:
	return "\n".join(lines)
