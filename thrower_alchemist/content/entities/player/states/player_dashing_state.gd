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

var character: CharacterBody2D:
	get: return agent

var original_change_direction: bool
var original_speed: float
var original_layer: int

var timer: Timer

func _ready() -> void:
	timer = Timer.new()
	timer.one_shot = true
	timer.wait_time = cooldown
	add_child(timer)
	
	self.set_guard(can_dash)

func can_dash() -> bool:
	return timer.is_stopped()

func _enter() -> void:
	
	original_change_direction = move_component.can_change_direction
	original_speed = move_component.speed
	original_layer = character.collision_mask

	var expression: Expression = Expression.new()
	expression.parse("original " + operator + " speed", ["original", "speed"])
	
	var value: float = expression.execute([original_speed, speed_value], self)
	
	if expression.has_execute_failed():
		_choose_transition()
		return
	
	move_component.can_change_direction = directionable
	move_component.speed = value
	character.collision_mask ^= PhysicsLayers.mask(PhysicsLayers.Enum.GROUND)
	GameDebugger.debug_log(PlayerDashingState, "New Character layers = " + str(character.collision_layer))
	
	get_tree().create_timer(dash_time).timeout.connect(_choose_transition)

func _exit() -> void:
	timer.start()
	move_component.speed = original_speed
	move_component.can_change_direction = original_change_direction
	character.collision_mask = original_layer

func _choose_transition() -> void:
	
	if move_input.axis == Vector2.ZERO:
		idle_transition.trigger()
		return
	
	move_transition.trigger()
