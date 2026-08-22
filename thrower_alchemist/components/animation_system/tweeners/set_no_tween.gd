@tool
extends NodeTweener

class_name SetNoTween

@export var deferred_call: bool = false

func make_animation(..._parameters: Array) -> void:
	
	await await_tweeners()
	
	state = TweenerState.Enum.PLAYING
	
	if not deferred_call:
		node.set(property_to_change, to)
	else:
		node.set_deferred(property_to_change, to)
	
	GameDebugger.debug_log(SetNoTween,
		'Setting property "' + property_to_change +
		'" to the node ' + str(node) + "\n" +
		"equal to = " + str(to)
	)
	
	finish()
