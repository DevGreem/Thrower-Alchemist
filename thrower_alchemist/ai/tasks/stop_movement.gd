extends BTAction

func _tick(_delta: float) -> Status:
	
	var actor: Node2D = agent as Node2D
	
	if not actor:
		return FAILURE
	
	var movement: MoveComponent2D = ComponentManager.get_component(actor, MoveComponent2D)
	
	if not movement:
		return FAILURE
	
	var result: bool = movement.set_direction(Vector2.ZERO)
	
	if result:
		return SUCCESS
	else:
		return FAILURE
