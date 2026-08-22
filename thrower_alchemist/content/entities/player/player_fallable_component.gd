extends FallableComponent2D

class_name PlayerFallableComponent

@export var state_machine: LimboHSM
@export var health_component: HealthComponent
@export var transition: BaseHSMTransitionAdder

func _ready() -> void:
	pass

func _fall(source: FallHoleArea2D) -> void:
	transition.trigger()
	
	SignalsUtilities.connect_signal(
		state_machine.active_state_changed,
		_on_change_state.bind(source),
		ConnectFlags.CONNECT_ONE_SHOT
	)

func _on_change_state(_current: LimboState, _previous: LimboState, source: FallHoleArea2D) -> void:
	health_component.health -= source.damage
	try_spawn(source)
