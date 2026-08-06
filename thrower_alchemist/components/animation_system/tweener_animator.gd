@abstract
@tool
extends Node

class_name TweenerAnimator

signal finished

@export var node: CanvasItem:
	set(value):
		node = value
		notify_property_list_changed()
		update_configuration_warnings()

@export var await_animators: Array[TweenerAnimator] = []

var state: TweenerState.Enum = TweenerState.Enum.IDLE

func _ready() -> void:
	if Engine.is_editor_hint():
		return
	
	if not node:
		node = get_parent()

func wait_finished() -> void:
	
	if state == TweenerState.Enum.FINISHED:
		return
		
	await finished

func await_tweeners() -> void:
	for animation: TweenerComponent in await_animators:
		if animation:
			await animation.wait_finished()

func _get_configuration_warnings() -> PackedStringArray:
	
	var warnings: PackedStringArray = []
	
	if not node:
		warnings.append("You must assign a node")
	
	return warnings
