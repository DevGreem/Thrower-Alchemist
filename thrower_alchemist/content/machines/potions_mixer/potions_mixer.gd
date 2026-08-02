@tool
extends Node2D

class_name PotionsMixerNode

@export var input_potions: Array[StaticPotionNode]
@export var output_potion: StaticPotionNode

func _ready() -> void:
	_on_set_potion_data()

func set_potion_data(potion_idx: int, data: PotionData) -> void:
	input_potions[potion_idx].data = data
	_on_set_potion_data()

func _on_set_potion_data() -> void:
	
	if input_potions.is_empty():
		output_potion.data = null
		return
	
	var new_data: PotionData = input_potions[0].data
	
	for i: int in range(1, input_potions.size()):
		
		if not input_potions[i].data:
			continue
		
		new_data = PotionData.join(new_data, input_potions[i].data)
	
	output_potion.data = new_data

func reset() -> void:
	for input: StaticPotionNode in input_potions:
		input.data = null
	
	output_potion.data = null
