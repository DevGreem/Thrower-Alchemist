extends Action

class_name PotionUseAction

func execute(executer: Object, actor: Object) -> void:
	
	var data: PotionData = executer as PotionData
	GameDebugger.debug_log(PotionUseAction, "data = " + str(data) + "; actor = " + str(actor))
	
	if not data:
		return
	
	if not data.can_throw:
		return
	
	if actor is Node2D:
		var potion: PotionNode = PotionNode.generate(actor as Node2D, executer as PotionData)
		potion.global_position = actor.global_position
		GameDebugger.debug_log(PotionUseAction, "New potion throwed = " + str(potion))
		
		EventBus.spawn_node_in_group(potion, ContainerType.Enum.PROJECTILES_CONTAINER)
		potion.throw.call_deferred(actor.get_global_mouse_position() as Vector2)
