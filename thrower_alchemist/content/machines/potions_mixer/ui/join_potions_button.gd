extends Button

class_name JoinPotionsButton

@export var potions_mixer: PotionsMixerNode

func _ready() -> void:
	
	if not self.pressed.is_connected(_on_pressed):
		self.pressed.connect(_on_pressed)

func _on_pressed() -> void:
	
	if not potions_mixer.can_mix():
		return
	
	var hotbar: HotbarComponent = ComponentManager.get_component(PlayerManager.current_player, HotbarComponent)
	
	var free_pos: int = hotbar.get_first_free_position()
	
	if free_pos == -1:
		return
	
	var result_potion: PotionData = potions_mixer.get_output_potion()
	potions_mixer.reset()
	
	hotbar.set_item_data(free_pos, result_potion)
