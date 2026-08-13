extends LimboHSM

class_name LimboStateMachine

@export var actor: Node
@export var default_state: LimboState
@export var start_automatically: bool = true

func _ready() -> void:
	self.initial_state = default_state
	
	if start_automatically:
		self.initialize(actor)
		self.set_active(true)

func change_state_by_path(node_name: NodePath) -> void:
	var node: LimboState = get_node(node_name)
	change_active_state(node)
