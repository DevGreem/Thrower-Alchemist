@tool
extends Control

class_name HealthBar

@export var target: HealthComponent:
	set = _on_set_target
@export var progress_bar: Range:
	set(value):
		
		if progress_bar == value:
			return
		
		progress_bar = value
		
		_update_progress_bar()

@export var change_heal_animation: TweenerAction

func _ready() -> void:
	progress_bar.min_value = 0

func _on_set_target(value: HealthComponent) -> void:
	
	if target == value:
		return
	
	_disconnect_target_signals()
	
	target = value
	
	if target:
		GameDebugger.debug_log(HealthBar, "New health component: " + target.name + " (" + str(target) + ")")
	else:
		GameDebugger.debug_log(HealthBar, "Health component setted to null")
	
	_connect_target_signals()
	_update_progress_bar()

func _connect_target_signals() -> void:
	
	if not target or Engine.is_editor_hint():
		return
	
	SignalsUtilities.connect_signals_persist({
		target.health_changed: [
			_on_health_changed
		],
		target.max_health_changed: [
			_on_max_health_changed
		]
	})

func _disconnect_target_signals() -> void:
	
	if not target or Engine.is_editor_hint():
		return
	
	SignalsUtilities.disconnect_signals({
		target.health_changed: [
			_on_health_changed
		],
		target.max_health_changed: [
			_on_max_health_changed
		]
	})

func _update_progress_bar() -> void:
	
	if not is_instance_valid(progress_bar):
		GameDebugger.debug_warning(HealthBar, "The progress bar not is valid", true)
		return
	
	if not target:
		
		if Engine.is_editor_hint():
			return
		
		GameDebugger.debug_log(HealthBar, "Target not assigned, hiding progress bar")
		progress_bar.hide()
		return
	
	GameDebugger.debug_log(HealthBar, "Showing progress bar")
	progress_bar.show()
	progress_bar.max_value = target.max_health
	progress_bar.value = target.health

func _on_health_changed(before: float, after: float) -> void:
	change_heal_animation.to = after
	change_heal_animation.duration = after/before
	change_heal_animation.make_animation()

func _on_max_health_changed(_before: float, after: float) -> void:
	progress_bar.max_value = after

func set_target_node(node: Node) -> void:
	
	if not is_instance_valid(node):
		target = null
		return
	
	GameDebugger.debug_log(HealthBar, "Setting new target with node " + node.name + " (" + str(node) + ")")
	var health_component: HealthComponent = ComponentManager.get_component(node, HealthComponent, true)
	
	GameDebugger.debug_log(HealthBar, "Getted the next health component: " + str(health_component))
	target = health_component
