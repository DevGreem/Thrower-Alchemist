@abstract
@tool
extends Resource

class_name TagData

@export var _id: StringName
var id: StringName:
	get: return _id

@export var _display_name: String
var display_name: String:
	get: return _display_name

@export var _color: Color = Color.WHITE
var color: Color:
	get: return _color

@export_multiline var _description: String
var description: String:
	get: return _description

## Don't finalized
@export var _behaviors: Array[TagBehavior] = []
var behaviors: Array[TagBehavior]:
	get: return _behaviors

func _validate_property(property: Dictionary) -> void:
	
	if property.name in ["_id", "_display_name", "_color", "_description", "_behaviors"]:
		property.usage |= PROPERTY_USAGE_READ_ONLY

func _tag_id() -> StringName:
	return self.get_class()
