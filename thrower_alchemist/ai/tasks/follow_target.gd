extends BTAction

@export var target_var: StringName = &"target"

func _tick(_delta: float) -> Status:
	
	var actor: Node2D = agent as Node2D
	var target: Node2D = blackboard.get_var(target_var)
	
	if not actor or not target:
		return FAILURE
	
	var movement: MoveComponent2D = ComponentManager.get_component(actor, MoveComponent2D)
	
	if not movement:
		return FAILURE
	
	movement.direction = actor.global_position.direction_to(target.global_position)
	
	return SUCCESS
