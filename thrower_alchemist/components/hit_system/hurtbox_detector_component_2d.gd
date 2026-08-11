extends Area2D

## Detects [HurtboxComponent2D] and bodies
class_name HurtboxDetectorComponent2D

signal hurtbox_detected(collider: Node2D)

@export var actor: Node
@export var detect_actor: bool = false

#TODO: Add a Hurtboxes Detector
func _ready() -> void:
	
	if not self.area_entered.is_connected(_on_collision_area_detected):
		area_entered.connect(_on_collision_area_detected)

func _on_collision_area_detected(area: Area2D) -> void:
	
	if area is HurtboxComponent2D:
		
		if not detect_actor and area.actor == self.actor:
			return
		
		hurtbox_detected.emit(area.actor)
