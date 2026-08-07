@abstract
@tool
extends TweenerAnimator

class_name PropertyTweenerAnimator

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
@export var delay: float = 0.0

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

@export var loops: int = 1
var tween: Tween

func _verify_tween() -> void:
	
	if tween and tween.is_valid():
		tween.kill()
	
	tween = node.create_tween()
	_connect_tween_signals()
	
func _connect_tween_signals() -> void:
	
	if not tween.finished.is_connected(_on_tween_finished):
		tween.finished.connect(_on_tween_finished)

func make_animation(..._parameters: Array) -> void:
	
	await await_tweeners()
	
	state = TweenerState.Enum.PLAYING
	_verify_tween()
	
	if add_ease:
		tween.set_ease(ease_type)
	
	if add_transition:
		tween.set_trans(trans_type)
	
	var tweener: PropertyTweener = tween.tween_property(node, property_to_change as NodePath, to, duration)
	tweener.set_delay(delay)
	
	if add_from:
		tweener.from(from)
	
	tween.set_loops(loops)
	GameDebugger.debug_log(TweenerComponent, "Playing tween animation")

func _on_tween_finished() -> void:
	state = TweenerState.Enum.FINISHED
	finished.emit()
	GameDebugger.debug_log(TweenerComponent, "Animation tween Finished")

func _get_names(properties: Array[Dictionary]) -> Array:
	return properties.map(
		func(property: Dictionary) -> StringName:
			return property.name
	)

func _validate_property(property: Dictionary) -> void:
	
	if node:
		
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
