extends Area2D

class_name HitboxComponent2D

signal damage_dealed

@export var actor: Node2D
@export var can_damage_actor: bool = false
@export var damage: float
@export var ignore_inmunity: bool = false
@export var activate_inmunity: bool = true

func _ready() -> void:
	
	if not area_entered.is_connected(_on_area_entered):
		area_entered.connect(_on_area_entered)
	
func _on_area_entered(area: Area2D) -> void:
	
	if area is HurtboxComponent2D:
		
		if area.actor == self.actor:
			if not can_damage_actor:
				return
		
		_make_damage(area as HurtboxComponent2D)

func _make_damage(area: HurtboxComponent2D) -> void:
	area.receive_damage(damage, ignore_inmunity, activate_inmunity)
	damage_dealed.emit()
