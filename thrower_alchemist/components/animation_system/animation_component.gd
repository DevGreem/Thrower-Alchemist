@tool
extends Node

class_name AnimationComponent

signal finished

@export var node: CanvasItem:
	set(value):
		node = value
		notify_property_list_changed()

@export var on_execute_signal: StringName:
	set(value):
		on_execute_signal = value
		notify_property_list_changed()
@export var property_to_change: String:
	set(value):
		property_to_change = value
		notify_property_list_changed()

@export var add_from: bool = false:
	set(value):
		add_from = value
		notify_property_list_changed()

@export var from: Variant = null
@export var to: Variant
@export var duration: float

@export var add_ease: bool = true:
	set(value):
		add_ease = value
		notify_property_list_changed()

@export var ease_type: Tween.EaseType

@export var add_transition: bool = true:
	set(value):
		add_transition = value
		notify_property_list_changed()

@export var trans_type: Tween.TransitionType
@export var loops: int = 0
@export var async: bool = false

var tween: Tween

func _ready() -> void:
	if Engine.is_editor_hint():
		return
	
	if not node.is_connected(on_execute_signal, _make_animation):
		node.connect(on_execute_signal, _make_animation)

func _verify_tween() -> void:
	
	if tween and tween.is_valid():
		tween.kill()
	
	tween = node.create_tween()
	_connect_tween_signals()
	
func _connect_tween_signals() -> void:
	
	if not tween.finished.is_connected(_on_tween_finished):
		tween.finished.connect(_on_tween_finished)
	
func _make_animation(..._parameters: Array) -> void:
	
	_verify_tween()
	
	if add_ease:
		tween.set_ease(ease_type)
	
	if add_transition:
		tween.set_trans(trans_type)
	
	tween.set_parallel(async)
	
	var tweener: PropertyTweener = tween.tween_property(node, property_to_change as NodePath, to, duration)
	
	if add_from:
		tweener.from(from)
	
	tween.set_loops(loops)
	GameDebugger.debug_log(AnimationComponent, "Playing tween animation")

func _on_tween_finished() -> void:
	finished.emit()

func _validate_property(property: Dictionary) -> void:
	
	if node:
		if property.name == "on_execute_signal":
			
			var signals: Array = _get_names(node.get_signal_list())
			
			property.hint = PROPERTY_HINT_ENUM
			property.hint_string = ",".join(signals)
		
		if property.name == "property_to_change":
			
			var properties: Array = _get_names(node.get_property_list())
			
			property.hint = PROPERTY_HINT_ENUM
			property.hint_string = ",".join(properties)
	
		if property_to_change:
			if property.name in ["from", "to"]:
				var value: Variant = node.get(property_to_change)
				
				property.type = typeof(value)
			
		if property.name == "from":
			
			if not add_from:
				property.usage = PROPERTY_USAGE_NO_EDITOR
	
	if property.name == "ease_type":
		
		if not add_ease:
			property.usage = PROPERTY_USAGE_NO_EDITOR
	
	if property.name == "trans_type":
		if not add_transition:
			property.usage = PROPERTY_USAGE_NO_EDITOR

func _get_names(properties: Array[Dictionary]) -> Array:
	return properties.map(
		func(property: Dictionary) -> StringName:
			return property.name
	)
