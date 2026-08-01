extends Node2D

class_name BurnedAreaEffect

@export var burn_area: TimeHitboxComponent2D
@export var reach_time_component: ReachTimeComponent

static func generate(actor: Node, cooldown: float = 1.0, time_alive: float = 1.1, damage: float = 3.0) -> BurnedAreaEffect:
	
	var node: BurnedAreaEffect = load("uid://41lqrvlsghmi").instantiate()
	node.burn_area.actor = actor
	node.burn_area.damage = damage
	node.burn_area.cooldown = cooldown
	node.reach_time_component.max_time_range = time_alive
	
	return node
