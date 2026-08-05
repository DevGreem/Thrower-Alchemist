extends Node

class_name HealthComponent

signal max_health_changed(before: float, after: float)
signal health_changed(before: float, after: float)
signal died

@export var actor: Node
@export var only_int: bool
@export var free_actor_on_die: bool = false

@export var max_health: float:
	set(value):
		
		if only_int:
			value = round(value)
		
		if value < health:
			health = value
		
		if max_health == value:
			return
		
		max_health_changed.emit(max_health, value)
		max_health = value

@export var start_health: float = -1.0

var health: float:
	set(value):
		
		if only_int:
			value = round(value)
		
		if value > max_health:
			value = max_health
		
		if health == value:
			return
		
		health_changed.emit(health, value)
		health = value
		GameDebugger.debug_log(HealthComponent, "new health = " + str(health))
		
		_verify_die()

func _ready() -> void:
	
	if start_health == -1.0:
		health = max_health
	else:
		health = start_health

func _verify_die() -> void:
	
	if health > 0.0:
		return
	
	died.emit()
	
	if free_actor_on_die:
		actor.queue_free()
