extends ShareableResource

class_name PotionData

signal effect_added
signal effect_removed

@export var can_drink: bool = true
@export var can_throw: bool = true
@export var weight: float
@export var effects: Array[PotionEffect] = []

static func join(left: PotionData, right: PotionData) -> PotionData:
	
	var new_potion: PotionData = PotionData.new()
	
	for left_effect: PotionEffect in left.effects:
		for right_effect: PotionEffect in right.effects:
			
			if left_effect.id == right_effect.id:
				continue
			
			if not PotionEffect.is_joinable(left_effect, right_effect):
				return null
			
			new_potion.add_effect(left_effect)
			new_potion.add_effect(right_effect)
	
	new_potion.reach_range = max(left.reach_range, right.reach_range)
	
	return new_potion

func add_effect(effect: PotionEffect) -> Error:
	
	if effect not in self.effects:
		self.effects.append(effect)
		
		effect_added.emit()
		return Error.OK
	
	return Error.ERR_ALREADY_EXISTS

func remove_effect(pos: int) -> void:
	
	pos = clamp(pos, 0, effects.size()-1)
	
	self.effects.remove_at(pos)
	effect_removed.emit()
