@abstract
@tool
extends ShareableResource

class_name PotionEffect

@export_custom(PROPERTY_HINT_TYPE_STRING, "", PROPERTY_USAGE_DEFAULT | PROPERTY_USAGE_READ_ONLY)
var _ID: String
@export_storage var id: String:
	get: return _ID

@export_custom(PROPERTY_HINT_COLOR_NO_ALPHA, "", PROPERTY_USAGE_DEFAULT | PROPERTY_USAGE_READ_ONLY)
var _COLOR: Color = Color.WHITE
@export_storage var color: Color:
	get: return _COLOR

@abstract
func _init() -> void

@abstract
func drink_effect(actor: Node2D) -> void

@abstract
func throw_effect(actor: Node2D, potion: PotionNode) -> void

@warning_ignore("unused_parameter")
func collision_effect(actor: Node2D, potion: PotionNode, collider: Node2D) -> void:
	GameDebugger.debug_log(PotionEffect, "Detected collision = " + str(collider))
	
	if collider:
		throw_effect(actor, potion)
		
		if potion:
			potion.queue_free()

static func is_joinable(left: PotionEffect, right: PotionEffect) -> bool:
	GameDebugger.debug_log(PotionEffect, "Trying join effect " + str(left.id) + " with " + str(right.id))
	var ids1: Array[StringName] = _search_ids(left, right)
	var ids2: Array[StringName] = _search_ids(right, left)
	
	return (not ids1.is_empty() or not ids2.is_empty())

static func _search_ids(left: PotionEffect, right: PotionEffect) -> Array[StringName]:
	return Databases.EFFECT_CONNECTIONS.where({
		"left": left.id,
		"right": right.id
	})
