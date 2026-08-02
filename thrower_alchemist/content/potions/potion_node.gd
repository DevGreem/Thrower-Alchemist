extends CharacterBody2D

class_name PotionNode

@onready var sprite: Sprite2D = $Sprite
@onready var move_component: MoveComponent2D = $%MoveComponent2D
@onready var reach_distance_component: ReachDistanceComponent2D = $%ReachDistanceComponent2D
@onready var collision_detector_component: CollisionDetectorComponent2D = $CollisionDetectorComponent2D

@export var actor: Node2D
@export var data: PotionData

static func generate(_actor: Node2D, _data: PotionData) -> PotionNode:
	
	var new_potion: PotionNode = load("uid://dmr3imp88ys2").instantiate()
	new_potion.actor = _actor
	new_potion.data = _data
	
	GameDebugger.debug_log(PotionNode, "Generated new potion with actor = " + str(_actor) + "; and data = " + str(_data))
	
	return new_potion

func _ready() -> void:
	collision_detector_component.actor = actor
	_update_data()

func _update_data() -> void:
	
	if not data:
		return
	
	sprite.self_modulate = data.get_potion_color()
	
	reach_distance_component.reach_distance /= data.weight

func _on_reach() -> void:
	
	for effect: PotionEffect in data.effects:
		_make_effect(effect)
	
	self.queue_free()

func _make_effect(effect: PotionEffect) -> void:
	effect.throw_effect(actor, self)

func _make_collision_effect(collider: Node2D) -> void:
	
	GameDebugger.debug_log(PotionNode, "Making Collision Effects")
	
	if collider is Area2D:
		if "actor" in collider:
			collider = collider.actor
	
	for effect: PotionEffect in data.effects:
		effect.collision_effect(actor, self, collider)

func throw(direction: Vector2) -> void:
	
	if not reach_distance_component.reached.is_connected(_on_reach):
		reach_distance_component.reached.connect(_on_reach)
	
	if not collision_detector_component.collision_detected.is_connected(_make_collision_effect):
		collision_detector_component.collision_detected.connect(_make_collision_effect)
	
	move_component.direction = self.global_position.direction_to(direction)
