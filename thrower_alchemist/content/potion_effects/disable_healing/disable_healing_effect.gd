@tool
extends PotionEffect

class_name DisableHealingEffect

@export var time: float
const META_ID: String = "disable_heal_counter"

func get_definition() -> PotionEffectDefinition:
	return PotionEffectDefinition.new(
		"disable_healing_effect",
		Color.DARK_RED
	)

func drink_effect(actor: Node2D) -> void:
	_disable_target_health(actor)

func throw_effect(_actor: Node2D, _potion: PotionNode) -> void:
	return

func collision_effect(_actor: Node2D, _potion: PotionNode, collider: Node2D) -> void:
	_disable_target_health(collider)

func _disable_target_health(target: Node) -> void:
	
	var health: HealthComponent = ComponentManager.get_component(target, HealthComponent, true)
	
	if not health:
		GameDebugger.debug_log(DisableHealingEffect, "HealthComponent not founded")
		return
	
	GameDebugger.debug_log(DisableHealingEffect, "Health of target disabled", true)
	
	var _counter: int = target.get_meta(META_ID, 0)
	_counter += 1
	
	target.set_meta(META_ID, _counter)
	
	health.can_change_health = false
	
	await target.get_tree().create_timer(time).timeout
	
	if not is_instance_valid(target):
		return
	
	if target.get_meta(META_ID, 0) != _counter:
		return
	
	health.can_change_health = true
	GameDebugger.debug_log(DisableHealingEffect, "Health of target enabled", true)
