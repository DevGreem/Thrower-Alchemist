extends LimboState

class_name PlayerDashingState

@export var move_component: MoveComponent2D
@export var idle_transition: BaseHSMTransitionAdder
@export var move_transition: BaseHSMTransitionAdder
@export var move_input: MoveInputComponent2D

@export var dash_time: float
@export_enum("+", "*", "-", "/") var operator: String
@export var speed_value: float

@export var directionable: bool = false
@export var cooldown: float
var remaining_cooldown: float = 0.0

var original_change_direction: bool
var original_speed: float

func _ready() -> void:
	
	if move_transition is BaseHSMTransitionAdder:
		if move_transition is HSMBidirectionalTransitionAdder:
			move_transition.guard = can_dash
			move_transition.register_transition()
		else:
			move_transition.guard = can_dash
			move_transition.register_transition()

func can_dash() -> bool:
	return remaining_cooldown <= 0.0

func _process(delta: float) -> void:
	remaining_cooldown -= delta

func _enter() -> void:
	
	original_change_direction = move_component.can_change_direction
	original_speed = move_component.speed

	var expression: Expression = Expression.new()
	expression.parse("original " + operator + " speed", ["original", "speed"])
	
	var value: float = expression.execute([original_speed, speed_value], self)
	
	if expression.has_execute_failed():
		_choose_transition()
		return
	
	move_component.can_change_direction = directionable
	move_component.speed = value
	
	get_tree().create_timer(dash_time).timeout.connect(_on_timeout_dash)

func _exit() -> void:
	remaining_cooldown = cooldown

func _on_timeout_dash() -> void:
	move_component.speed = original_speed
	move_component.can_change_direction = original_change_direction
	
	if move_input.axis == Vector2.ZERO:
		return
	
	move_transition.trigger()

func _choose_transition() -> void:
	
	if move_input.axis == Vector2.ZERO:
		idle_transition.trigger()
		return
	
	move_transition.trigger()
