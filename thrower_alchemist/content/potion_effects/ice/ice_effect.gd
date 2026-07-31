extends PotionEffect

class_name IceEffect

@export var freeze_time: float

func drink_effect(actor: Node2D) -> void:
	
	var components: Dictionary = ComponentManager.get_components(actor, [MoveComponent2D, InputManagerComponent])
	var move_component: MoveComponent2D = components[MoveComponent2D]
	var input_manager: InputManagerComponent = components[InputManagerComponent]
	
	if not move_component:
		return
	
	move_component.can_move = false
	input_manager.deactivate_all()
	
	_set_sprite_effect(actor, Color.BLUE)
	
	await actor.get_tree().create_timer(freeze_time).timeout
	
	move_component.can_move = true
	input_manager.activate_all()
	_set_sprite_effect(actor, Color.WHITE)

func throw_effect(actor: Node2D, potion: PotionNode) -> void:
	pass

func _set_sprite_effect(actor: Node, _color: Color = Color.BLUE) -> void:
	
	var sprite: Sprite2D = ComponentManager.get_component(actor, Sprite2D)
	
	if not sprite:
		return
	
	var material: ShaderMaterial = sprite.material
	
	if not material:
		return
	
	material.set_shader_parameter("EffectColor", _color)
