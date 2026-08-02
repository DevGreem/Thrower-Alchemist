extends Area2D

class_name VisionComponent2D

signal entity_entered(entity: Node2D)
signal entity_exited(entity: Node2D)

@export var actor: Node
@export var required_tags: Array[TagData] = []
@export var detect_bodies: bool = true
@export var detect_hurtboxes: bool = false
@export var can_see_through_walls: bool = false

var visible_entities: Array[Node2D] = []

func _ready() -> void:
	
	if detect_bodies:
		if not body_entered.is_connected(_on_body_entered):
			body_entered.connect(_on_body_entered)
		
		if not body_exited.is_connected(_on_body_exited):
			body_exited.connect(_on_body_exited)
	
	if detect_hurtboxes:
		
		if not area_entered.is_connected(_on_hurtbox_entered):
			area_entered.connect(_on_hurtbox_entered)
		
		if not area_exited.is_connected(_on_hurtbox_exited):
			area_exited.connect(_on_hurtbox_exited)

func _on_body_entered(body: Node2D) -> void:
	
	GameDebugger.debug_log(VisionComponent2D, "Body detected")
	
	if body == actor:
		GameDebugger.debug_log(VisionComponent2D, "The body was me")
		return
	
	if _is_valid_node(body):
		visible_entities.append(body)
		entity_entered.emit(body)
	
	GameDebugger.debug_log(VisionComponent2D, "Entities cantity = " + str(visible_entities.size()))

func _on_body_exited(body: Node2D) -> void:
	
	GameDebugger.debug_log(VisionComponent2D, "Body exited")
	
	if body == actor:
		return
	
	if body in visible_entities:
		visible_entities.erase(body)
		entity_exited.emit(body)
	
	GameDebugger.debug_log(VisionComponent2D, "Entities cantity = " + str(visible_entities.size()))

func _on_hurtbox_entered(area: Area2D) -> void:
	
	if area is HurtboxComponent2D:
		_on_body_entered(area.actor as Node2D)

func _on_hurtbox_exited(area: Area2D) -> void:
	
	if area is HurtboxComponent2D:
		_on_body_exited(area.actor as Node2D)

func _is_valid_node(body: Node) -> bool:
	
	if required_tags.is_empty():
		return true
	
	for tag: TagData in required_tags:
		if TagsManager.has_tag(tag, body):
			return true
	
	return false

func _can_see(target: Node2D) -> bool:
	
	if can_see_through_walls:
		return true
	
	var space: PhysicsDirectSpaceState2D = get_world_2d().direct_space_state
	
	var query: PhysicsRayQueryParameters2D = PhysicsRayQueryParameters2D.create(
		global_position,
		target.global_position
	)
	
	var result: Dictionary = space.intersect_ray(query)
	query.collision_mask = PhysicsLayers.mask(PhysicsLayers.Enum.VISION_BLOCKERS)
	
	if result.is_empty():
		return true
	
	return result.collider == target
