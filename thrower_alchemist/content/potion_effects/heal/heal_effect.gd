@tool
extends PotionEffect

class_name HealEffect

@export var heal: float

func _init() -> void:
	_ID = "heal_effect"
	_COLOR = Color.LIME_GREEN

func drink_effect(actor: Node2D) -> void:
	_heal_target(actor)

func throw_effect(_actor: Node2D, _potion: PotionNode) -> void:
	return

func collision_effect(_actor: Node2D, _potion: PotionNode, collider: Node2D) -> void:
	_heal_target(collider)

func _heal_target(target: Node) -> void:
	
	var health: HealthComponent = ComponentManager.get_component(target, HealthComponent, true)
	
	if not _has_health_component(health):
		return
	
	GameDebugger.debug_log(HealEffect, "Target healed " + str(heal) + " health")
	health.health += heal

func _has_health_component(health_component: HealthComponent) -> bool:
	
	if health_component:
		return true
	else:
		GameDebugger.debug_log(HealEffect, "HealthComponent not founded")
		return false
