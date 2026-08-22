@abstract
@tool
extends Node

class_name TweenerAnimator

signal finished

@export var await_animators: Array[TweenerAnimator] = []

@warning_ignore("unused_private_class_variable")
@export_tool_button("Preview animation") var _preview: Callable = preview_animation

var state: TweenerState.Enum = TweenerState.Enum.IDLE

func wait_finished() -> void:
	
	if state == TweenerState.Enum.FINISHED:
		return
		
	await finished

func await_tweeners() -> void:
	
	for animation: TweenerAnimator in await_animators:
		if animation:
			await animation.wait_finished()

@abstract
func preview_animation() -> void

func finish() -> void:
	state = TweenerState.Enum.FINISHED
	finished.emit()
	GameDebugger.debug_log(TweenerAnimator, 'Animation "' + str(self.name) + '" finished')

@abstract
func make_animation(...parameters: Array) -> void
