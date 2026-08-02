extends Area2D

class_name HurtboxComponent2D

signal damage_received(cantity: float)
signal heal_received(cantity: float)

@export var health_component: HealthComponent
@export var actor: Node
@export var inmunity_time: float = -1.0
@export var invincible: bool = false
@export var can_heal: bool = true

var inmunity_remaining: float = -1.0

func _process(delta: float) -> void:
	
	if inmunity_remaining > 0.0:
		inmunity_remaining -= delta

func receive_damage(cantity: float, activate_inmunity: bool = true, ignore_inmunity: bool = false) -> bool:
	
	if not ignore_inmunity:
		if inmunity_remaining > 0.0:
			return false
	
	if invincible:
		return false
	
	health_component.health -= cantity
	damage_received.emit(cantity)
	
	if activate_inmunity:
		inmunity_remaining = inmunity_time
	
	return true

func receive_heal(cantity: float) -> bool:
	
	if not can_heal:
		return false
	
	health_component.health += cantity
	heal_received.emit(cantity)
	return true
