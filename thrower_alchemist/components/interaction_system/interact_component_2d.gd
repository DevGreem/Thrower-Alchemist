@tool
extends Node2D

class_name InteractComponent2D

@export var interact_area: Area2D:
	set(value):
		interact_area = value
		update_configuration_warnings()

@export var interaction_ui: Node
@export var can_interact: bool = true
@export var can_interact_through_walls: bool = false

@onready var player: Node2D = get_tree().get_first_node_in_group("player")
var detected_areas: Dictionary[InteractArea2D, bool] = {}
var focused_interactable: InteractArea2D

func _ready() -> void:
	
	if Engine.is_editor_hint():
		return
	
	if not interact_area.area_entered.is_connected(register_area):
		interact_area.area_entered.connect(register_area)
	
	if not interact_area.area_exited.is_connected(unregister_area):
		interact_area.area_exited.connect(unregister_area)

func register_area(area: InteractArea2D) -> void:
	
	if detected_areas.has(area):
		return
	
	detected_areas[area] = false

func unregister_area(area: InteractArea2D) -> bool:
	return detected_areas.erase(area)

func _process(_delta: float) -> void:
	
	if Engine.is_editor_hint():
		return
	
	if not can_interact or detected_areas.is_empty():
		return
	
	for area: InteractArea2D in detected_areas:
		detected_areas[area] = _can_reach(area)
	
	focused_interactable = _get_closer_interactable()
	
	if not focused_interactable:
		return
	
	GameDebugger.debug_log(InteractComponent2D, "Closer interactable = " + str(focused_interactable))
	
	if not interaction_ui:
		return
	
	

func _get_closer_interactable() -> InteractArea2D:
	
	if detected_areas.is_empty() or not player:
		return null
	
	var best_area: InteractArea2D = null
	var best_distance: float = INF
	
	for area: InteractArea2D in detected_areas:
		
		if not detected_areas[area]:
			continue
		
		var distance: float = player.global_position.distance_to(area.global_position)
		
		if distance < best_distance:
			best_distance = distance
			best_area = area
	
	return best_area
	
func _sort_by_distance_to_player(a: InteractArea2D, b: InteractArea2D) -> bool:
	
	if not player:
		return true
	
	var distance1: float = player.global_position.distance_to(a.global_position)
	var distance2: float = player.global_position.distance_to(b.global_position)
	
	return distance1 > distance2

func _can_reach(target: Node2D) -> bool:
	
	if can_interact_through_walls:
		return true
	
	var space: PhysicsDirectSpaceState2D = get_world_2d().direct_space_state
	
	var query: PhysicsRayQueryParameters2D = PhysicsRayQueryParameters2D.create(
		global_position,
		target.global_position
	)
	
	query.exclude = [self]
	query.collision_mask = PhysicsLayers.mask(PhysicsLayers.Enum.INTERACTIONS)
	var result: Dictionary = space.intersect_ray(query)
	
	if result.is_empty():
		return true
	
	return result.collider == target

func _get_configuration_warnings() -> PackedStringArray:
	
	var warnings: PackedStringArray = []
	
	if not interact_area:
		warnings.append("InteractComponent2D needs an Area2D!")
	
	return warnings
