extends Action

class_name PotionInteractAction

func execute(executer: Object, actor: Object) -> void:
	
	var potion: PotionData = executer as PotionData
	
	assert(potion, "The potion don't exists!")
	
	if not potion.can_drink:
		return
	
	if actor is Node2D:
		potion.drink_effects(actor as Node2D)
