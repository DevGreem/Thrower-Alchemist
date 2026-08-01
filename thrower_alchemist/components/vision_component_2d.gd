extends Area2D

class_name VisionComponent2D

signal entity_entered(entity: Node2D)
signal entity_exited(entity: Node2D)

@export var required_tags: Array[TagData] = []
@export var detect_bodies: bool = true
@export var detect_hurtboxes: bool = false

var visible_entities: Array[Node2D] = []

func _ready() -> void:
	
	if detect_bodies:
		if not body_entered.is_connected(_on_body_entered):
			body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	
	pass

func _is_valid_node(body: Node) -> bool:
	
	if required_tags.is_empty():
		return true
	
	for tag: TagData in required_tags:
		if TagsManager.has_tag(tag, body):
			return true
	
	return false
