extends Control

class_name PotionMixerUI

@export var potions_mixer: PotionsMixerNode
@export var input_slots: Array[MixerSlot] = []
@export var output_slot: MixerSlot = null
@export var join_button: JoinPotionsButton

func _ready() -> void:
	
	if not potions_mixer.potion_setted.is_connected(_on_potion_setted):
		potions_mixer.potion_setted.connect(_on_potion_setted)
	
	join_button.potions_mixer = potions_mixer
	join_button.pressed.connect(_on_potions_joined)
	_init_slots()
	
	_on_potion_setted()
	
	GameDebugger.debug_log(PotionMixerUI, "Initialized Potion Mixer UI")

func _init_slots() -> void:
	for i: int in range(input_slots.size()):
		var input: MixerSlot = input_slots[i]
		input.potions_mixer = potions_mixer
		input.idx = i
		input.potion_icon.set_color(potions_mixer.get_potion_data(i))
	
	output_slot.potions_mixer = potions_mixer
	output_slot.potion_icon.set_color(potions_mixer.get_output_potion())

func _on_potion_setted() -> void:
	
	for i: int in range(input_slots.size()):
		var input: MixerSlot = input_slots[i]
		input.potion_icon.set_color(potions_mixer.get_potion_data(i))
	
	output_slot.potion_icon.set_color(potions_mixer.get_output_potion())

func _get_hotbar() -> HotbarComponent:
	return ComponentManager.get_component(PlayerManager.current_player, HotbarComponent)

func _on_potions_joined() -> void:
	pass
