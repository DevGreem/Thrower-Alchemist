extends ShareableResource

class_name PotionEffectConnection

@export var left: String
@export var right: String

static func is_any(value: String, id1: String, id2: String) -> bool:
	return value in [id1, id2]
