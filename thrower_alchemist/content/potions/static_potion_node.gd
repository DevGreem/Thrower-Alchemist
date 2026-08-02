extends Node2D

class_name StaticPotionNode

@export var sprite: Sprite2D
@export var data: PotionData:
	set(value):
		
		if data == value:
			return
		
		data = value
		
		_change_color()

const FILLED_POTION: Texture2D = preload("uid://dfgj4org13j6b")
const EMPTY_POTION: Texture2D = preload("uid://dpphmkh2rnqvp")

func _change_color() -> void:
	
	if not data:
		_set_default_color()
		return
	
	if data.effects.is_empty():
		_set_default_color()
		return
	
	var new_color: Color = data.get_potion_color()
	
	sprite.texture = FILLED_POTION
	sprite.self_modulate = new_color

func _set_default_color() -> void:
	sprite.texture = EMPTY_POTION
	sprite.self_modulate = Color.WHITE
