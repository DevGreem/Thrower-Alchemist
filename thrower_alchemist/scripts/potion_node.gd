extends Node2D

class_name PotionNode

@onready var sprite: Sprite2D = $Sprite
@onready var move_component: MoveComponent2D = $%MoveComponent2D
@onready var reach_range_component: ReachRangeComponent = $%ReachRangeComponent

@export var actor: Node2D
@export var data: PotionData

func _ready() -> void:
	_update_data()
	
	var mouse_pos: Vector2 = get_global_mouse_position()
	move_component.direction = self.global_position.direction_to(mouse_pos)
	
	if not reach_range_component.reached.is_connected(_on_reach):
		reach_range_component.reached.connect(_on_reach)

func _update_data() -> void:
	
	if not data:
		return
	
	for effect: PotionEffect in data.effects:
		sprite.self_modulate *= effect.color
	
	reach_range_component.max_reach_range /= data.weight

func _on_reach() -> void:
	
	for effect: PotionEffect in data.effects:
		effect.throw_effect(actor)
	
	self.queue_free()
