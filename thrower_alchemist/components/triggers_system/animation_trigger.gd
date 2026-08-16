@tool
extends TriggerNode

class_name AnimationTrigger

enum ActionType {
	PLAY,
	PAUSE,
	STOP
}

@export var animation_player: AnimationPlayer:
	set(value):
		animation_player = value
		notify_property_list_changed()

@export var action_type: ActionType = ActionType.PLAY:
	set(value):
		action_type = value
		notify_property_list_changed()

@export var animation_name: StringName

func execute(..._parameters: Array) -> void:
	GameDebugger.debug_log(AnimationTrigger, "Executing animation \"" + animation_name + "\" with action " + str(action_type))
	
	if action_type == ActionType.STOP:
		animation_player.stop()
		return
	
	if action_type == ActionType.PAUSE:
		animation_player.pause()
		return
	
	animation_player.play(animation_name)

func _validate_property(property: Dictionary) -> void:
	
	super._validate_property(property)
	
	if property.name == "animation_name":
		
		if action_type != ActionType.PLAY:
			property.usage = PROPERTY_USAGE_NO_EDITOR
			return
		
		if not animation_player:
			return
		
		property.hint = PROPERTY_HINT_ENUM
		property.hint_string = ",".join(animation_player.get_animation_list())
