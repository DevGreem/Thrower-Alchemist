@tool
extends LimboState

class_name FallingState

@export var animation_player: AnimationPlayer
@export var animation_name: StringName = &"falling"
@export var move_component: MoveComponent2D
@export var flip_component: FlipComponent2D

func _enter() -> void:
	
	if move_component:
		move_component.can_move = false
	
	if flip_component:
		flip_component.active = false
	
	if animation_player:
		animation_player.play(animation_name)

func _exit() -> void:
	
	if move_component:
		move_component.can_move = true
	
	if flip_component:
		flip_component.active = true

func _validate_property(property: Dictionary) -> void:
	
	if property.name == "animation_name":
		
		if not animation_player:
			return
		
		property.hint = PROPERTY_HINT_ENUM
		property.hint_string = ",".join(animation_player.get_animation_list())
	
