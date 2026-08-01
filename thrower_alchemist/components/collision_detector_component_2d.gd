extends Area2D

## Detects [HurtboxComponent2D] and bodies
class_name CollisionDetectorComponent2D

signal collision_detected(collider: Node2D)

@export var actor: Node
@export var detect_actor: bool = false
@export var detect_hurtboxes: bool = false

func _ready() -> void:
	
	if not self.body_entered.is_connected(_on_collision_detected):
		body_entered.connect(_on_collision_detected)
	
	if not detect_hurtboxes:
		return
	
	if not self.area_entered.is_connected(_on_collision_area_detected):
		area_entered.connect(_on_collision_area_detected)

func _on_collision_detected(body: Node2D) -> void:
	
	if not detect_actor:
		
		if body == actor:
			return
	
	collision_detected.emit(body)

func _on_collision_area_detected(area: Area2D) -> void:
	
	if area is HurtboxComponent2D:
		
		if not detect_actor and area.actor == self.actor:
			return
		
		collision_detected.emit(area.actor)
