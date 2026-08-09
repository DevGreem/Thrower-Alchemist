@tool
extends NodeTweener

class_name SetNoTween

func make_animation(..._parameters: Array) -> void:
	
	await await_tweeners()
	
	state = TweenerState.Enum.PLAYING
	
	node.set(property_to_change, to)
	
	finish()
