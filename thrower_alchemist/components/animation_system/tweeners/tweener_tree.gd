@tool
extends BaseTweenerTreeAnimator

class_name TweenerTree

var _running_children: int = 0

func preview_animation() -> void:
	
	if not Engine.is_editor_hint():
		return
	
	for child: Node in get_children():
		if child is TweenerAnimator:
			child.preview_animation()

func make_animation(..._parameters: Array) -> void:
	
	if state == TweenerState.Enum.PLAYING:
		return
	
	await await_tweeners()
	state = TweenerState.Enum.PLAYING
	_running_children = animations.size()
	
	if _running_children == 0:
		_finish_animation()
		return
	
	for animation: TweenerAnimator in animations:
		play_child(animation)

func play_child(
	child: TweenerAnimator,
	parameters: Array = []
) -> void:
	@warning_ignore("redundant_await")
	await child.make_animation(parameters)
	
	_running_children -= 1
	
	if _running_children == 0:
		_finish_animation()

func _finish_animation() -> void:
	
	for animation: TweenerAnimator in animations:
		animation.state = TweenerState.Enum.IDLE
	
	finish()
