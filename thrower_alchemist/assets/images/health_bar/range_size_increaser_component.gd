@tool
extends Node

class_name RangeSizeIncreaserComponent

@export var target: TextureProgressBar

func _on_set_target(value: Range) -> void:
	
	if target == value:
		return
	
	_disconnect_target_signals()
	
	target = value
	
	_connect_target_signals()

func _connect_target_signals() -> void:
	
	if not target:
		return
	
	SignalsUtilities.connect_signal(target.changed, _on_changed)

func _disconnect_target_signals() -> void:
	
	if not target:
		return
	
	SignalsUtilities.disconnect_signal(target.changed, _on_changed)

func _on_changed() -> void:
	
	const X_FILL: Array[TextureProgressBar.FillMode] = [
		TextureProgressBar.FILL_LEFT_TO_RIGHT,
		TextureProgressBar.FILL_RIGHT_TO_LEFT
	]
	
	const Y_FILL: Array[TextureProgressBar.FillMode] = [
		TextureProgressBar.FILL_TOP_TO_BOTTOM,
		TextureProgressBar.FILL_BOTTOM_TO_TOP
	]
	
	if target.fill_mode in X_FILL:
		target.custom_minimum_size.x = target.max_value
	elif target.fill_mode in Y_FILL:
		target.custom_minimum_size.y = target.max_val
	else:
		GameDebugger.debug_warning(RangeSizeIncreaserComponent, "Target fill mode not compatible")
	
