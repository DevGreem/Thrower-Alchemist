@tool
extends PropertyTweenerAnimator

class_name TweenerComponent

@export var on_execute_signal: StringName:
	set(value):
		on_execute_signal = value
		notify_property_list_changed()

func _ready() -> void:
	if Engine.is_editor_hint():
		return
	
	super._ready()
	
	if not node.is_connected(on_execute_signal, make_animation):
		node.connect(on_execute_signal, make_animation)

func _validate_property(property: Dictionary) -> void:
	super._validate_property(property)
	
	if node:
		if property.name == "on_execute_signal":
			
			var signals: Array = _get_names(node.get_signal_list())
			
			property.hint = PROPERTY_HINT_ENUM
			property.hint_string = ",".join(signals)
