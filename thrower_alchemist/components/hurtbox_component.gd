extends Area2D

class_name HurtboxComponent2D

@export var health_component: HealthComponent
@export var invincible: bool = false

func receive_damage(cantity: float) -> void:
	
	if invincible:
		return
	
	health_component.health -= cantity
