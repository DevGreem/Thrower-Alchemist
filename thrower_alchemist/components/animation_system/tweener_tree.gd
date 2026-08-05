@tool
extends TweenerAnimator

class_name TweenerTree

@export var on_execute_signal: StringName:
	set(value):
		on_execute_signal = value
		notify_property_list_changed()

func _ready() -> void:
	
	if Engine.is_editor_hint():
		
		if not child_order_changed.is_connected(_on_order_changed):
			child_order_changed.connect(_on_order_changed)
		
		return
	
	super._ready()
	
	if not node.is_connected(on_execute_signal, _execute_actions):
		node.connect(on_execute_signal, _execute_actions)

func _execute_actions(..._parameters: Array) -> void:
	
	await await_tweeners()
	
	for child: Node in get_children():
		if child is PropertyTweenerAnimator:
			child.make_animation()

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
