extends PotionEffect

class_name IceEffect

@export var freeze_time: float

const META_ID: String = "freeze_counter"

func drink_effect(actor: Node2D) -> void:
	_freeze_actor(actor)

func throw_effect(_actor: Node2D, _potion: PotionNode) -> void:
	return

func collision_effect(_actor: Node2D, potion: PotionNode, collider: Node2D) -> void:

	if collider:
		_freeze_actor(collider as Node2D)
	
	if potion:
		potion.queue_free()

func _set_sprite_effect(actor: Node, _color: Color = Color.BLUE) -> void:
	
	var sprite: Sprite2D = ComponentManager.get_component(actor, Sprite2D)
	
	if not sprite:
		return
	
	var material: ShaderMaterial = sprite.material
	
	if not material:
		return
	
	material.set_shader_parameter("EffectColor", _color)

func _freeze_actor(actor: Node2D) -> bool:
	
	if actor is PlayerNode:
		return await _freeze_player(actor as PlayerNode)
	
	return await _freeze_entity(actor)

func _freeze_entity(entity: Node2D) -> bool:
	return await _start_freeze(entity)

func _freeze_player(player: PlayerNode) -> bool:
	var input_manager: InputManagerComponent = ComponentManager.get_component(player, InputManagerComponent)

	input_manager.deactivate_all()
	
	var answer: bool = await _start_freeze(player)
	
	input_manager.activate_all()
	
	return answer

func _start_freeze(actor: Node2D) -> bool:
	var move_component: MoveComponent2D = ComponentManager.get_component(actor, MoveComponent2D)
	GameDebugger.debug_log(IceEffect, "Starting freezing")
	
	if not move_component:
		return false
	
	var _counter: int = actor.get_meta(META_ID, 0)
	_counter += 1
	
	actor.set_meta(META_ID, _counter)
	
	move_component.can_move = false
	_set_sprite_effect(actor, Color.BLUE)
	
	await actor.get_tree().create_timer(freeze_time).timeout
	
	if _counter != actor.get_meta(META_ID, null):
		return false
	
	move_component.can_move = true
	_set_sprite_effect(actor, Color.WHITE)
	
	GameDebugger.debug_log(IceEffect, "Finished freezing")
	
	return true
