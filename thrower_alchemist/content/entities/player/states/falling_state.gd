@tool
extends LimboState

class_name FallingState

@export var fall_audio_requester: AudioRequester
@export var animation_player: AnimationPlayer
@export var animation_name: StringName
@export var reset_animation_name: StringName
@export var move_component: MoveComponent2D
@export var flip_component: FlipComponent2D
@export var unfall_transition: BaseHSMTransitionAdder

func _ready() -> void:
	set_guard(_guard)
	
	if not animation_player.animation_finished.is_connected(_on_finish_animation):
		animation_player.animation_finished.connect(_on_finish_animation)

func _guard() -> bool:
	return not blackboard.get_var(&"was_dashing")

func _enter() -> void:
	
	if fall_audio_requester:
		fall_audio_requester.request_play()
	
	if move_component:
		move_component.can_move = false
	
	if flip_component:
		flip_component.active = false
	
	if animation_player:
		
		if animation_player.has_animation(animation_name):
			animation_player.play(animation_name)
		else:
			GameDebugger.debug_error(
				FallingState,
				"Not founded the animation on animation player"
			)

func _exit() -> void:
	
	if move_component:
		move_component.can_move = true
	
	if flip_component:
		flip_component.active = true

func _on_finish_animation(anim_name: StringName) -> void:
	
	if unfall_transition.state_machine.get_active_state() != self:
		return
	
	if anim_name == animation_name:
		unfall_transition.trigger()
	
	if animation_player:
		
		if animation_player.has_animation(reset_animation_name):
			animation_player.play(reset_animation_name)
		else:
			GameDebugger.debug_error(FallingState, "Not founded the reset animation on animation player", true)

func _validate_property(property: Dictionary) -> void:
	
	if property.name in ["animation_name", "reset_animation_name"]:
		
		if not animation_player:
			return
		
		property.hint = PROPERTY_HINT_ENUM
		property.hint_string = ",".join(animation_player.get_animation_list())
	
