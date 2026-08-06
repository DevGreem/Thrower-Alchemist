@tool
extends Node

class_name PotionIconComponent

@export var icon_node: CanvasItem:
	set(value):
		icon_node = value
		update_configuration_warnings()

const FILLED_POTION: Texture2D = preload("uid://dfgj4org13j6b")
const EMPTY_POTION: Texture2D = preload("uid://dpphmkh2rnqvp")

func _ready() -> void:
	
	if not icon_node.texture:
		set_color(null)

func set_color(data: PotionData) -> void:
	
	if not data:
		_set_default_color()
		return
	
	if data.effects.is_empty():
		_set_default_color()
		return
	
	var new_color: Color = data.get_potion_color()
	
	icon_node.texture = FILLED_POTION
	icon_node.self_modulate = new_color

func _set_default_color() -> void:
	icon_node.texture = EMPTY_POTION
	icon_node.self_modulate = Color.WHITE

func _get_configuration_warnings() -> PackedStringArray:
	
	var warnings: PackedStringArray = []
	
	if icon_node is not Sprite2D and icon_node is not TextureRect:
		warnings.append("Icon Node must be a Sprite2D or a TextureRect")
	
	return warnings
