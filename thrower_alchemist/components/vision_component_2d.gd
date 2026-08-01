extends Area2D

class_name VisionComponent2D

signal entity_entered(entity: Node2D)
signal entity_exited(entity: Node2D)

@export var groups_to_detect: Array[StringName] = []
@export var detect_bodies: bool = true
@export var detect_hurtboxes: bool = false

var visible_entities: Array[Node2D] = []

func _ready() -> void:
	
	if detect_bodies:
		if not body_entered.is_connected(_on_body_entered):
			body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	pass
