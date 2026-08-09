extends RoomObjective

class_name KillAllEnemiesObjective

@export var enemies_container: Node

func _ready() -> void:
	
	if not enemies_container.child_exiting_tree.is_connected(_on_die_enemy):
		enemies_container.child_exiting_tree.connect(_on_die_enemy)
	
	_on_die_enemy()

func _on_die_enemy() -> void:
	
	await get_tree().process_frame
	
	if enemies_container.get_child_count() == 0:
		complete()
