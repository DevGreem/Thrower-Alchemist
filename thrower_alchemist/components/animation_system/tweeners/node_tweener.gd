@abstract
@tool
extends TweenerAnimator

class_name NodeTweener

@export var node: CanvasItem:
	set(value):
		node = value
		notify_property_list_changed()
		update_configuration_warnings()

@export var property_to_change: String:
	set(value):
		property_to_change = value
		notify_property_list_changed()

@export var to: Variant = null

func preview_animation() -> void:
	
	if not Engine.is_editor_hint():
		return
	
	if not node or not property_to_change:
		return
	
	var original_value: Variant = node.get(property_to_change)
	
	@warning_ignore("redundant_await")
	await make_animation()
	
	_restore_state(original_value)

func _restore_state(original_value: Variant) -> void:
	
	if not Engine.is_editor_hint():
		return
	
	node.set(property_to_change, original_value)

func _get_names(properties: Array[Dictionary]) -> Array:
	return properties.map(
		func(property: Dictionary) -> StringName:
			return property.name
	)

func _validate_property(property: Dictionary) -> void:
	
	if not node:
		return
	
	if property.name == "property_to_change":
			
		var properties: Array = _get_names(node.get_property_list())
			
		property.hint = PROPERTY_HINT_ENUM
		property.hint_string = ",".join(properties)
	
	if property_to_change:
		if property.name == "to":
			var value: Variant = node.get(property_to_change)
			
			var type: int = typeof(value)
			property.type = type
			
			if not to:
				to = type_convert(null, type)

func _get_configuration_warnings() -> PackedStringArray:
	
	var warnings: PackedStringArray = []
	
	if not node:
		warnings.append("You must assign a node")
	
	return warnings
