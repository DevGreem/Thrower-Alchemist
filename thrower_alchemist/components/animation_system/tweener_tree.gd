@tool
extends TweenerAnimator

class_name TweenerTree

@export var on_execute_signal: StringName:
	set(value):
		on_execute_signal = value
		notify_property_list_changed()

var _running_children: int = 0
var animations: Array[TweenerAnimator]

func _ready() -> void:
	
	if Engine.is_editor_hint():
		
		if not child_order_changed.is_connected(_on_order_changed):
			child_order_changed.connect(_on_order_changed)
		
		return
	
	super._ready()
	update_childrens()
	
	if not node.is_connected(on_execute_signal, make_animation):
		node.connect(on_execute_signal, make_animation)

func preview_animation() -> void:
	
	if not Engine.is_editor_hint():
		return
	
	for child: Node in get_children():
		if child is TweenerAnimator:
			child._preview_animation()

func make_animation(..._parameters: Array) -> void:
	
	if state == TweenerState.Enum.PLAYING:
		return
	
	await await_tweeners()
	state = TweenerState.Enum.PLAYING
	_running_children = animations.size()
	
	if _running_children == 0:
		_finish_animation()
		return
	
	for animation: TweenerAnimator in animations:
		play_child(animation)
	

func update_childrens() -> void:
	
	animations.clear()
	
	for child: Node in get_children():
		if child is TweenerAnimator:
			animations.append(child)

func play_child(
	child: TweenerAnimator,
	parameters: Array = []
) -> void:
	@warning_ignore("redundant_await")
	await child.make_animation(parameters)
	
	_running_children -= 1
	
	if _running_children == 0:
		_finish_animation()

func _finish_animation() -> void:
	state = TweenerState.Enum.FINISHED
	
	for animation: TweenerAnimator in animations:
		animation.state = TweenerState.Enum.IDLE
	
	finished.emit()

func _on_order_changed() -> void:
	
	for child: Node in get_children():
		if child is PropertyTweenerAnimator:
			if child.node:
				continue
			
			child.node = self.node

func _validate_property(property: Dictionary) -> void:
	
	if node:
		if property.name == "on_execute_signal":
			
			var signals: Array = node.get_signal_list().map(
				func(prop: Dictionary) -> StringName:
					return prop.name
			)
			
			property.hint = PROPERTY_HINT_ENUM
			property.hint_string = ",".join(signals)
