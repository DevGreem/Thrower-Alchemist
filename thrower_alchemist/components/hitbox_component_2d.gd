extends Area2D

class_name HitboxComponent2D

signal damage_dealed

@export var actor: Node2D
@export var can_damage_actor: bool = false
@export var damage: float

func _ready() -> void:
	
	if not area_entered.is_connected(_on_area_entered):
		area_entered.connect(_on_area_entered)
	
func _on_area_entered(area: Area2D) -> void:
	
	if area is HurtboxComponent2D:
		
		if area.get_parent() == self.actor:
			if not can_damage_actor:
				return
		
		area.receive_damage(damage)
		damage_dealed.emit()
