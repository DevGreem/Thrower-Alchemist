extends Control

class_name PotionMixerUI

@export var potions_mixer: PotionsMixerNode
@export var input_slots: Array[MixerSlot] = []
@export var output_slot: MixerSlot = null

func _ready() -> void:
	
	for input: MixerSlot in input_slots:
		input.ui_manager = self
	
	output_slot.ui_manager = self
	
	GameDebugger.debug_log(PotionMixerUI, "Initialized Potion Mixer UI")
