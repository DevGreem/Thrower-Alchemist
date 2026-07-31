extends Node2D

class_name BurnedAreaEffect

@export var burn_area: HitboxComponent2D

static func generate(actor: Node) -> BurnedAreaEffect:
	
	var node: BurnedAreaEffect = load("uid://41lqrvlsghmi").instantiate()
	node.burn_area.actor = actor
	
	return node
