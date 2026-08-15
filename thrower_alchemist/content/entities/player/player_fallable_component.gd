extends FallableComponent2D

class_name PlayerFallableComponent

@export var state_machine: LimboHSM
@export var health_component: HealthComponent
@export var transition: BaseHSMTransitionAdder

func _fall(source: FallHoleArea2D) -> void:
	health_component.health -= source.damage
	transition.trigger()
	
	if not state_machine.active_state_changed.is_connected(_on_change_state):
		state_machine.active_state_changed.connect(_on_change_state)

func _on_change_state(_current: LimboState, _previous: LimboState) -> void:
	
	actor.scale = Vector2.ONE
	
	if state_machine.active_state_changed.is_connected(_on_change_state):
		state_machine.active_state_changed.disconnect(_on_change_state)
