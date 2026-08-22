@tool
extends BaseTweenerTreeAnimator

class_name RandomTweenerSelector

func preview_animation() -> void:
	return

func make_animation(..._parameters: Array) -> void:
	
	if state == TweenerState.Enum.PLAYING:
		return
	
	await await_tweeners()
	state = TweenerState.Enum.PLAYING
	
	if animations.is_empty():
		finish()
		return
	
	var tween_to_execute: TweenerAnimator = animations.pick_random()
	tween_to_execute.finished.connect(_on_finish_tween.bind(tween_to_execute))
	
	tween_to_execute.make_animation()

func _on_finish_tween(tween: TweenerAnimator) -> void:
	
	finish()
	tween.finished.disconnect(_on_finish_tween.bind(tween))
