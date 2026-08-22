@tool
extends Node

class_name PropertyWriter

@export var search_limit: int = 1:
	set(value):
		search_limit = value
		notify_property_list_changed()

@export var target: Node:
	set(value):
		target = value
		notify_property_list_changed()
		
@export var property_to_write: StringName
@export var label: Control:
	set(value):
		
		if value and not (value is Label or value is RichTextLabel):
			GameDebugger.debug_error(PropertyWriter, "Tryied assign a target that not is a type of label")
			return
		
		label = value

func _ready() -> void:
	update_text()

func update_text() -> void:
	
	if not label or not target:
		return
	
	label.text = str(target.get_indexed(NodePath(property_to_write)))

func _validate_property(property: Dictionary) -> void:
	
	if property.name == "property_to_write":
		
		if not target:
			return
		
		var properties: Array[StringName] = PropertiesUtilities.get_all_properties_names(target, "", search_limit)
		
		property.hint = PROPERTY_HINT_ENUM
		property.hint_string = ",".join(properties)
	
	if property.name == "label":
		property.hint_string = "Label,RichTextLabel"
