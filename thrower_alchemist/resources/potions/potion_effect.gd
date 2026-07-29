@abstract
extends ShareableResource

class_name PotionEffect

@export var _ID: String
var id: String:
	get: return _ID

@export var color: Color = Color.WHITE

@abstract
func drink_effect(actor: Node2D) -> void

@abstract
func throw_effect(actor: Node2D) -> void

static func is_joinable(left: PotionEffect, right: PotionEffect) -> bool:
	
	var ids: Array[StringName] = Databases.EFFECT_CONNECTIONS.where({
		"left": left.id,
		"right": right.id
	})
	
	return not ids.is_empty()
