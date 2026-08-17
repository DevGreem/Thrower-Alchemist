@tool
extends Node

class_name RandomModulateColorGenerator

@export var target: CanvasItem
@export var self_modulate: bool = true
@export var min_values: Color
@export var max_values: Color

@export_tool_button("Change preview color") var change_preview_color: Callable = change_color

func _ready() -> void:
	if Engine.is_editor_hint():
		return
	
	change_color()

func change_color() -> void:
	var color: Color = _generate_random_color(min_values, max_values)
	
	if self_modulate:
		target.self_modulate = color
	else:
		target.modulate = color

static func _generate_random_color(min_val: Color, max_val: Color) -> Color:
	return Color(
		randf_range(min_val.r, max_val.r),
		randf_range(min_val.g, max_val.g),
		randf_range(min_val.b, max_val.b),
		randf_range(min_val.a, max_val.a)
	)
