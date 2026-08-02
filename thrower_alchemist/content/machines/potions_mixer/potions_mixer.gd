extends Node2D

class_name PotionsMixerNode

@export var input_potions: Array[StaticPotionNode]
@export var output_potion: StaticPotionNode

func set_potion_color(potion_idx: int, color: Color) -> void:
	input_potions[potion_idx].color = color
	_on_set_potion_color()

func _on_set_potion_color() -> void:
	
	
	
	pass
