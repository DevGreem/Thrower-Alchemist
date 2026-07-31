extends PotionEffect

class_name BurnEffect

func drink_effect(actor: Node2D) -> void:
	
	GameDebugger.debug_log(BurnEffect, "Trying to drink potion")
	var health_component: HealthComponent = ComponentManager.get_component(actor, HealthComponent)
	
	if not health_component:
		GameDebugger.debug_log(BurnEffect, "Actor don't have the HealthComponent")
		return
	
	GameDebugger.debug_log(BurnEffect, "Removed health to actor")
	health_component.health -= 20

func throw_effect(actor: Node2D, potion: PotionNode) -> void:
	
	var explosive_area: BurnedAreaEffect = BurnedAreaEffect.generate(actor)
	explosive_area.global_position = potion.global_position
	
	EventBus.spawn_node(explosive_area, ContainerType.Enum.EFFECTS_CONTAINER)
