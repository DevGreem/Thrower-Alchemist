@abstract
@tool
extends ShareableResource

class_name PotionEffect

@export_custom(PROPERTY_HINT_RESOURCE_TYPE, "", PROPERTY_USAGE_DEFAULT | PROPERTY_USAGE_READ_ONLY)
var definition: PotionEffectDefinition:
	get: return get_definition()
	set(value): return

@abstract
func get_definition() -> PotionEffectDefinition

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
	
	GameDebugger.debug_log(PotionEffect, 'Trying join effects "' + left.definition.id + '" + "' + right.definition.id + '"')
	GameDebugger.debug_log(
		PotionEffect,
		'Join Modes = "' + PotionJoinMode.as_string(left.definition.join_mode) + '" - "' + PotionJoinMode.as_string(right.definition.join_mode) + '"'
	)
	
	#GameDebugger.debug_log(PotionEffect, "Trying join effect " + str(JSON.from_native(left.definition)) + " with " + str(JSON.from_native(right.definition, true)))
	var ids1: Array[StringName] = _search_ids(left, right)
	var ids2: Array[StringName] = _search_ids(right, left)
	
	GameDebugger.debug_log(
		PotionEffect,
		"Result:\nids1 = " + str(ids1) + "\nids2 = " + str(ids2)
	)
	if left.definition.join_mode == PotionJoinMode.Enum.DENY\
		or right.definition.join_mode == PotionJoinMode.Enum.DENY:
		
		return ids1.is_empty() and ids2.is_empty()
	
	return not ids1.is_empty() or not ids2.is_empty()

static func _search_ids(left: PotionEffect, right: PotionEffect) -> Array[StringName]:
	return Databases.EFFECT_CONNECTIONS.where({
		"left": left.definition.id,
		"right": right.definition.id
	})
