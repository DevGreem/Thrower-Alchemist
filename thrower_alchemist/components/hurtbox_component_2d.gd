extends Area2D

class_name HurtboxComponent2D

signal damage_received(cantity: float)
signal heal_received(cantity: float)

@export var health_component: HealthComponent
@export var actor: Node
@export var inmunity_time: float = -1.0
@export var invincible: bool = false

var inmunity_remaining: float = -1.0

func _ready() -> void:
	inmunity_remaining = inmunity_time

func _process(delta: float) -> void:
	
	if inmunity_remaining > 0.0:
		inmunity_remaining -= delta

func receive_damage(cantity: float, activate_inmunity: bool = true, ignore_inmunity: bool = false) -> void:
	
	if not ignore_inmunity:
		if inmunity_remaining > 0.0:
			return
	
	if invincible:
		return
	
	health_component.health -= cantity
	damage_received.emit(cantity)
	
	if activate_inmunity:
		inmunity_remaining = inmunity_time

func receive_heal(cantity: float) -> void:
	
	health_component.health += cantity
	heal_received.emit(cantity)
