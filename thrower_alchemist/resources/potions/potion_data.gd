extends ShareableResource

class_name PotionData

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
			
			if not left_effect in new_potion.effects:
				new_potion.effects.append(left_effect)
			
			if not right_effect in new_potion.effects:
				new_potion.effects.append(right_effect)
	
	new_potion.reach_range = max(left.reach_range, right.reach_range)
	
	return new_potion

func add_effect(effect: PotionEffect) -> Error:
	
	if effect not in self.effects:
		self.effects.append(effect)
		return Error.OK
	
	return Error.ERR_ALREADY_EXISTS
