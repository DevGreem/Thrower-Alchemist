extends Node2D

class_name InteractionManager2D

@export var interaction_ui: Node
@export var can_interact: bool = true

var player: Node2D = get_tree().get_first_node_in_group("player")
var active_areas: Array[InteractionArea2D] = []

func register_area(area: InteractionArea2D) -> void:
	active_areas.append(area)

func unregister_area(area: InteractionArea2D) -> bool:
	var idx: int = active_areas.find(area)
	
	if idx != -1:
		active_areas.remove_at(idx)
		return true
	
	return false

func _process(_delta: float) -> void:
	
	if active_areas.is_empty():
		return
	
	if not can_interact:
		return
	
	active_areas.sort_custom(_sort_by_distance_to_player)

func _sort_by_distance_to_player(a: InteractionArea2D, b: InteractionArea2D) -> bool:
	
	if not player:
		return true
	
	var distance1: float = player.global_position.distance_to(a.global_position)
	var distance2: float = player.global_position.distance_to(b.global_position)
	
	return distance1 > distance2
