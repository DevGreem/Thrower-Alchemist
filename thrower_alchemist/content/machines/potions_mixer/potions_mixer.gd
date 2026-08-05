@tool
extends StaticBody2D

class_name PotionsMixerNode

signal potion_setted
signal exploded

@export var input_potions: Array[StaticPotionNode]
@export var output_potion: StaticPotionNode
@export var interaction_area: InteractArea2D

func _ready() -> void:
	_on_set_potion_data()
	
	if Engine.is_editor_hint():
		return
	
	interaction_area.interact = _on_interact

func set_potion_data(potion_idx: int, data: PotionData) -> void:
	input_potions[potion_idx].data = data
	_on_set_potion_data()

func reset() -> void:
	
	for i: int in range(input_potions.size()):
		set_potion_data(i, null)
	
	output_potion.data = null

func get_potion_data(potion_idx: int) -> PotionData:
	return input_potions[potion_idx].data

func get_output_potion() -> PotionData:
	return output_potion.data

func explode() -> void:
	exploded.emit()
	self.queue_free()

func _on_set_potion_data() -> void:
	
	if input_potions.is_empty():
		output_potion.data = null
		return
	
	var new_data: PotionData = input_potions[0].data
	
	for i: int in range(1, input_potions.size()):
		
		if not input_potions[i].data:
			continue
		
		var query: JoinStatus = PotionData.join(new_data, input_potions[i].data)
		
		if query.status == JoinStatus.Status.EXPLODED:
			explode()
			return
		
		new_data = query.result
	
	output_potion.data = new_data
	potion_setted.emit()

func _on_interact() -> void:
	interaction_area.active = false
	var ui: PotionMixerUI = load("uid://rilhj81wbcge").instantiate()
	ui.potions_mixer = self
	UIManager.open(ui)
	
	ui.tree_exited.connect(_on_exit_ui)
	
	get_tree().paused = true

func _on_exit_ui() -> void:
	interaction_area.active = true
	get_tree().paused = false

func can_mix() -> bool:
	
	var output: PotionData = get_output_potion()
	
	return output != null
