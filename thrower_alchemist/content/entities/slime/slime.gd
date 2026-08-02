extends Entity

class_name SlimeNode

@onready var behavior: BTPlayer = $Behavior
@onready var vision_component: VisionComponent2D = $VisionComponent2D
@onready var state_machine: LimboStateMachine = $LimboStateMachine

func _ready() -> void:
	
	behavior.blackboard.set_var("state_machine", state_machine)
	behavior.blackboard.set_var("entities_cantity", 0)
	behavior.blackboard.set_var("attack_entity", null)
	
	if not vision_component.entity_entered.is_connected(_on_entity_detected):
		vision_component.entity_entered.connect(_on_entity_detected)
	
	if not vision_component.entity_exited.is_connected(_on_entity_detected):
		vision_component.entity_exited.connect(_on_entity_detected)

func _on_entity_detected(_entity: Node) -> void:
	_set_attack_entities()

func _set_attack_entities() -> void:
	var arr: Array[Node2D] = vision_component.visible_entities
	
	GameDebugger.debug_log(SlimeNode, "Setting Entities to attack in slime = " + str(arr.size()) + str(arr))
	behavior.blackboard.set_var("entities_cantity", arr.size())
	
	if arr.size() > 0:
		behavior.blackboard.set_var("attack_entity", arr.front())
	else:
		behavior.blackboard.set_var("attack_entity", null)
