extends Entity

class_name SlimeNode

@onready var behavior: BTPlayer = $Behavior
@onready var vision_component: VisionComponent2D = $VisionComponent2D

func _ready() -> void:
	
	if not vision_component.entity_entered.is_connected(_on_entity_entered):
		vision_component.entity_entered.connect(_on_entity_entered)

func _on_entity_entered(_entity: Node) -> void:
	_set_attack_entities()

func _on_entity_exited(_entity: Node) -> void:
	_set_attack_entities()

func _set_attack_entities() -> void:
	var arr: Array[Node2D] = vision_component.visible_entities
	
	behavior.blackboard.set_var("entities_cantity", arr.size())
	behavior.blackboard.set_var("attack_entities", arr)
