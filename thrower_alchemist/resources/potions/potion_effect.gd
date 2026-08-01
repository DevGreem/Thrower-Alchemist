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
func throw_effect(actor: Node2D, potion: PotionNode) -> void

@warning_ignore("unused_parameter")
func collision_effect(actor: Node2D, potion: PotionNode, collider: Node2D) -> void:
	GameDebugger.debug_log(PotionEffect, "Detected collision = " + str(collider))
	
	if collider:
		throw_effect(actor, potion)
		potion.queue_free()

static func is_joinable(left: PotionEffect, right: PotionEffect) -> bool:
	
	var ids: Array[StringName] = Databases.EFFECT_CONNECTIONS.where({
		"left": PotionEffectConnection.is_any.bind(left, right),
		"right": PotionEffectConnection.is_any.bind(left, right)
	})
	
	return not ids.is_empty()
