extends Node2D

class_name PotionNode

@onready var sprite: Sprite2D = $Sprite
@onready var move_component: MoveComponent2D = $%MoveComponent2D
@onready var reach_distance_component: ReachDistanceComponent2D = $%ReachDistanceComponent2D

@export var actor: Node2D
@export var data: PotionData

static func generate(_actor: Node2D, _data: PotionData) -> PotionNode:
	
	var new_potion: PotionNode = load("uid://dmr3imp88ys2").instantiate()
	new_potion.actor = _actor
	new_potion.data = _data
	
	return new_potion

func _ready() -> void:
	_update_data()
	
	var mouse_pos: Vector2 = get_global_mouse_position()
	move_component.direction = self.global_position.direction_to(mouse_pos)
	
	if not reach_distance_component.reached.is_connected(_on_reach):
		reach_distance_component.reached.connect(_on_reach)

func _update_data() -> void:
	
	if not data:
		return
	
	for effect: PotionEffect in data.effects:
		sprite.self_modulate *= effect.color
	
	reach_distance_component.reach_distance /= data.weight

func _on_reach() -> void:
	
	for effect: PotionEffect in data.effects:
		_make_effect(effect)
	
	self.queue_free()

func _make_effect(effect: PotionEffect) -> void:
	effect.throw_effect(actor, self)
