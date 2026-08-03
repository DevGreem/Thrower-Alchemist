extends Control

class_name PotionMixerUI

@export var potions_mixer: PotionsMixerNode
@export var input_slots: Array[MixerSlot] = []
@export var output_slot: MixerSlot = null

func _ready() -> void:
	
	if not potions_mixer.potion_setted.is_connected(_on_potion_setted):
		potions_mixer.potion_setted.connect(_on_potion_setted)
	
	for i: int in range(input_slots.size()):
		var input: MixerSlot = input_slots[i]
		input.ui_manager = self
		input.potion_icon.set_color(potions_mixer.get_potion_data(i))
		input.pressed.connect(_input_pressed.bind(i))
	
	output_slot.ui_manager = self
	output_slot.potion_icon.set_color(potions_mixer.get_output_potion())
	
	_on_potion_setted()
	
	GameDebugger.debug_log(PotionMixerUI, "Initialized Potion Mixer UI")

func _input_pressed(idx: int) -> void:
	var hotbar: HotbarComponent = ComponentManager.get_component(PlayerManager.current_player, HotbarComponent)
	
	var item: PotionData = hotbar.get_item_selected().data as PotionData
	
	potions_mixer.set_potion_data(idx, item)

func _on_potion_setted() -> void:
	
	for i: int in range(input_slots.size()):
		var input: MixerSlot = input_slots[i]
		input.potion_icon.set_color(potions_mixer.get_potion_data(i))
	
	output_slot.potion_icon.set_color(potions_mixer.get_output_potion())
