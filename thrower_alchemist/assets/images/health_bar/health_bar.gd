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

func _ready() -> void:
	progress_bar.min_value = 0

func _on_set_target(value: HealthComponent) -> void:
	
	if target == value:
		return
	
	_disconnect_target_signals()
	
	target = value
	
	_connect_target_signals()

func _connect_target_signals() -> void:
	
	if not target:
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
	
	if not target:
		return
	
	SignalsUtilities.connect_signals_persist({
		target.health_changed: [
			_on_health_changed
		],
		target.max_health_changed: [
			_on_max_health_changed
		]
	})

func _update_progress_bar() -> void:
	
	if not is_instance_valid(progress_bar):
		return
	
	if not Engine.is_editor_hint():
		if not target:
			progress_bar.hide()
			return
	
	progress_bar.max_value = target.max_health
	progress_bar.value = target.health

func _on_health_changed(_before: float, after: float) -> void:
	progress_bar.value = after

func _on_max_health_changed(_before: float, after: float) -> void:
	progress_bar.value = after
