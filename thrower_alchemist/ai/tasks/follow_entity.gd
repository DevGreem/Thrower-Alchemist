extends BTAction

class_name BTFollowEntityAction

@export var move_component_path: NodePath:
	set(value):
		
		if move_component_path == value:
			return
		
		move_component_path = value
var move_component: MoveComponent2D

func _tick(delta: float) -> Status:
	
	if move_component is not MoveComponent2D:
		GameDebugger.debug_error(BTFollowEntityAction, "This not is a MoveComponent2D!")
		return Status.FAILURE
	
	var entities: Array[Node2D] = blackboard.get_var("attack_entities")
	
	if not entities:
		return Status.FAILURE
	
	if entities.is_empty():
		return Status.FAILURE
	
	return Status.SUCCESS
