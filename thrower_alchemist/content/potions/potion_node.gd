extends CharacterBody2D

class_name PotionNode

signal brokened

@export var move_component: MoveComponent2D
@export var reach_distance_component: ReachDistanceComponent2D
@export var hurtbox_detector: HurtboxDetectorComponent2D

@export var actor: Node2D
@export var data: PotionData:
	set(value):
		data = value
		_update_data()

@export var potion_icon_component: PotionIconComponent

static func generate(_actor: Node2D, _data: PotionData) -> PotionNode:
	
	var new_potion: PotionNode = load("uid://dmr3imp88ys2").instantiate()
	new_potion.actor = _actor
	new_potion.data = _data
	
	GameDebugger.debug_log(PotionNode, "Generated new potion with actor = " + str(_actor) + "; and data = " + str(_data))
	
	return new_potion

func _ready() -> void:
	hurtbox_detector.actor = self.actor
	_update_data()

func _update_data() -> void:
	
	if not data:
		return
	
	potion_icon_component.set_color(data)
	
	reach_distance_component.reach_distance /= data.weight

func _on_reach() -> void:
	
	for effect: PotionEffect in data.effects:
		_make_effect(effect)
	
	break_glass()

func _make_effect(effect: PotionEffect) -> void:
	effect.throw_effect(actor, self)

func _make_collision_effect(collider: Node2D) -> void:
	
	GameDebugger.debug_log(PotionNode, "Making Collision Effects")
	
	if collider is Area2D:
		if "actor" in collider:
			collider = collider.actor
	
	for effect: PotionEffect in data.effects:
		effect.collision_effect(actor, self, collider)
	
	break_glass()

func break_glass() -> void:
	brokened.emit()
	self.queue_free()

func throw(direction: Vector2) -> void:
	move_component.set_direction(self.global_position.direction_to(direction))
