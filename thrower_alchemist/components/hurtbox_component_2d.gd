extends Area2D

class_name HurtboxComponent2D

signal damage_received(cantity: float)

@export var health_component: HealthComponent
@export var inmunity_time: float
@export var invincible: bool = false

func receive_damage(cantity: float) -> void:
	
	if invincible:
		return
	
	health_component.health -= cantity
	damage_received.emit(cantity)
