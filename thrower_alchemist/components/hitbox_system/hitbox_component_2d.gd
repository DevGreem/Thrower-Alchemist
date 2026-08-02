extends Area2D

class_name HitboxComponent2D

signal damage_dealed

@export var actor: Node2D
@export var can_damage_actor: bool = false
@export var damage: float
@export var ignore_inmunity: bool = false
@export var activate_inmunity: bool = true

var entered_hurtboxes: Array[HurtboxComponent2D] = []

func _ready() -> void:
	
	if not area_entered.is_connected(_on_area_entered):
		area_entered.connect(_on_area_entered)
	
	if not area_exited.is_connected(_on_area_exited):
		area_exited.connect(_on_area_exited)

func _process(_delta: float) -> void:
	
	for hurtbox: HurtboxComponent2D in entered_hurtboxes:
		_make_damage(hurtbox)
	
func _on_area_entered(area: Area2D) -> void:
	
	if area is HurtboxComponent2D:
		
		if area.actor == self.actor:
			if not can_damage_actor:
				return
		
		entered_hurtboxes.append(area)

func _on_area_exited(area: Area2D) -> void:
	
	if area is HurtboxComponent2D:
		entered_hurtboxes.erase(area)

func _make_damage(area: HurtboxComponent2D) -> void:
	var hitted: bool = area.receive_damage(damage, activate_inmunity, ignore_inmunity)
	
	if hitted:
		damage_dealed.emit()
