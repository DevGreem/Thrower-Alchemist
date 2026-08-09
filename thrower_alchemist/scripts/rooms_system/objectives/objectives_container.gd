@tool
extends Node

class_name ObjectivesContainer

signal all_completed
signal objective_completed(objective: Variant)

var objectives: Dictionary[RoomObjective, bool] = {}

func _ready() -> void:
	
	for child: Node in get_children():
		
		if child is RoomObjective:
			add_objective(child as RoomObjective)

func add_objective(objective: RoomObjective) -> void:
	objectives[objective] = objective.is_completed
	
	if not objective.is_completed:
		_connect_objective(objective)

func _connect_objective(objective: RoomObjective) -> void:
	
	if not objective.completed.is_connected(_on_complete_objective.bind(objective)):
		objective.completed.connect(_on_complete_objective.bind(objective))

func _on_complete_objective(objective: RoomObjective) -> void:
	objectives[objective] = true
	objective_completed.emit(objective)
	_verify_all_objectives_completed()

func _verify_all_objectives_completed() -> void:
	
	for objective: RoomObjective in objectives:
		if not objectives[objective]:
			return
	
	all_completed.emit()

func _get_configuration_warnings() -> PackedStringArray:
	
	var warnings: PackedStringArray = []
	
	if get_child_count() == 0:
		warnings.append("You must add objectives")
	
	return warnings
