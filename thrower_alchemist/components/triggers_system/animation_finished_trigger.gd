@tool
extends ExecuteTrigger

class_name AnimationFinishedTrigger

var animation_player: AnimationPlayer:
	get: return node
	
@export var on_finish_animations: Array[StringName] = []

func _ready() -> void:
	signal_to_connect = "animation_finished"
	super._ready()

func execute(anim_name: StringName = "", ...parameters: Array) -> void:
	
	if anim_name not in on_finish_animations:
		return
	
	GameDebugger.debug_log(AnimationFinishedTrigger, "Finished animation " + anim_name + " executing method")
	super.execute(parameters)

func _validate_property(property: Dictionary) -> void:
	
	super._validate_property(property)
	
	if property.name == "node":
		property.hint_string = "AnimationPlayer,AnimationTree"
	
	if property.name == "signal_to_connect":
		property.usage |= PROPERTY_USAGE_READ_ONLY
	
	if property.name == "on_finish_animations":
		
		if not animation_player:
			return
		
		property.hint = PROPERTY_HINT_TYPE_STRING
		
		property.hint_string = "%d/%d:%s" % [
			TYPE_STRING_NAME,
			PROPERTY_HINT_ENUM,
			",".join(animation_player.get_animation_list())
		]
