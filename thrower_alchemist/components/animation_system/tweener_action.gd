@tool
extends NodeTweener

class_name TweenerAction

@export var add_from: bool = false:
	set(value):
		add_from = value
		notify_property_list_changed()

@export var from: Variant = 0.0
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

func _ready() -> void:
	
	if Engine.is_editor_hint():
		return
	
	GameDebugger.debug_log(TweenerAction, "to = " + str(to))
	GameDebugger.debug_log(TweenerAction, "to type = " + str(typeof(to)))
	GameDebugger.debug_log(TweenerAction, "to type name = " + str(type_string(typeof(to))))

func _verify_tween() -> bool:
	
	if not node:
		GameDebugger.debug_warning(TweenerAction, "Node assigned removed and executing animation")
		return false
	
	if tween and tween.is_valid():
		tween.kill()
	
	tween = node.create_tween()
	_connect_tween_signals()
	return true
	
func _connect_tween_signals() -> void:
	
	if not tween.finished.is_connected(finish):
		tween.finished.connect(finish)
	
func make_animation(..._parameters: Array) -> void:
	
	await await_tweeners()
	
	state = TweenerState.Enum.PLAYING
	var ok: bool = _verify_tween()
	
	if not ok:
		return
	
	if add_ease:
		tween.set_ease(ease_type)
	
	if add_transition:
		tween.set_trans(trans_type)
	
	var tweener: PropertyTweener = tween.tween_property(node, property_to_change as NodePath, to, duration)
	
	if tweener:
		tweener.set_delay(delay)
		
		if add_from:
			tweener.from(from)
	else:
		GameDebugger.debug_error(TweenerAction, "Tweener not created")
	
	tween.set_loops(loops)
	GameDebugger.debug_log(TweenerAction, "Playing tween animation")

func _validate_property(property: Dictionary) -> void:
	super._validate_property(property)
	
	if node:
	
		if property_to_change:
			if property.name == "from":
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
