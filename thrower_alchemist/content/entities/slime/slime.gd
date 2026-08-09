extends Entity

class_name SlimeNode

@export var behavior: BTPlayer
@export var vision_component: VisionComponent2D

func _ready() -> void:
	
	behavior.blackboard_plan.create_blackboard(self)

func _set_attack_entities(..._parameters: Array) -> void:
	var arr: Array[Node2D] = vision_component.visible_entities
	
	GameDebugger.debug_log(SlimeNode, "Setting Entities to attack in slime = " + str(arr.size()) + str(arr))
	behavior.blackboard.set_var("entities_cantity", arr.size())
	
	if arr.size() > 0:
		behavior.blackboard.set_var("target", arr.front())
	else:
		behavior.blackboard.set_var("target", null)
