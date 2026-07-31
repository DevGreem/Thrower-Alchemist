extends PotionEffect

class_name BurnEffect

func drink_effect(_actor: Node2D) -> void:
	pass

func throw_effect(actor: Node2D, potion: PotionNode) -> void:
	
	var explosive_area: BurnedAreaEffect = BurnedAreaEffect.generate(actor)
	explosive_area.global_position = potion.global_position
	
	EventBus.spawn_node(explosive_area, ContainerType.Enum.EFFECTS_CONTAINER)
