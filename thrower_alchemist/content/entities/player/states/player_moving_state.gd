extends LimboState

class_name PlayerMovingState

@export var move_input: MoveInputComponent2D
@export var dash_input: DashInput
@export var stop_transition: BaseHSMTransitionAdder
@export var dash_transition: BaseHSMTransitionAdder

func _ready() -> void:
	set_guard(
		func() -> bool:
			return move_input.move_component.can_move
	)

func _enter() -> void:
	GameDebugger.debug_log(PlayerMovingState, "CONNECTED")
	dash_input.dash_requested.connect(_on_dash_requested)

func _exit() -> void:
	GameDebugger.debug_log(PlayerMovingState, "DISCONNECTED")
	dash_input.dash_requested.disconnect(_on_dash_requested)

func _update(_delta: float) -> void:
	
	if move_input.axis == Vector2.ZERO:
		stop_transition.trigger()

func _on_dash_requested() -> void:
	GameDebugger.debug_log(PlayerMovingState, "Trying to change to dash state")
	dash_transition.trigger()
