@tool
extends PotionEffect

class_name BurnEffect

@export var damage: float = 20.0
@export var times: int = 4
@export var time_alive: float
var cooldown: float:
	get: return time_alive/times

func _init() -> void:
	_ID = "burn_effect"
	_COLOR = Color.ORANGE_RED

func drink_effect(actor: Node2D) -> void:
	
	GameDebugger.debug_log(BurnEffect, "Trying to drink potion")
	var health_component: HealthComponent = ComponentManager.get_component(actor, HealthComponent)
	
	if not health_component:
		GameDebugger.debug_log(BurnEffect, "Actor don't have the HealthComponent")
		return
	
	GameDebugger.debug_log(BurnEffect, "Removed health to actor")
	
	for i: int in range(times):
		health_component.health -= damage
		
		await actor.get_tree().create_timer(cooldown).timeout

func throw_effect(actor: Node2D, potion: PotionNode) -> void:
	
	var burn_area: BurnedAreaEffect = BurnedAreaEffect.generate(actor, cooldown, time_alive, damage)
	burn_area.global_position = potion.global_position
	
	EventBus.spawn_node.call_deferred(burn_area, ContainerType.Enum.EFFECTS_CONTAINER)
