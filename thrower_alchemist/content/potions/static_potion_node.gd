@tool
extends Node2D

class_name StaticPotionNode

@export var sprite: Sprite2D
@export var data: PotionData:
	set(value):
		
		if data == value:
			return
		
		data = value
		_change_color()
@export var potion_icon: PotionIconComponent

func _change_color() -> void:
	potion_icon.set_color(data)
