@tool
extends InventoryItemData

class_name PotionData

signal effect_added
signal effect_removed

@export var can_drink: bool = true
@export var can_throw: bool = true
@export var weight: float
@export var effects: Array[PotionEffect] = []:
	set(value):
		
		effects = value
		
		if effects:
			for effect: PotionEffect in effects:
				effect = effect.duplicate(true)

func _init() -> void:
	self.icon = preload("uid://dfgj4org13j6b")
	
	if not self.actions:
		self.actions = ItemActions.new()
	
	self.actions.use = PotionUseAction.new()
	self.actions.interact = PotionInteractAction.new()

func _validate_property(property: Dictionary) -> void:
	
	if property.name == "icon":
		property.usage |= PROPERTY_USAGE_READ_ONLY
	
	if property.name == "actions":
		property.usage |= PROPERTY_USAGE_READ_ONLY

func drink_effects(actor: Node2D) -> void:
	
	for effect: PotionEffect in effects:
		effect.drink_effect(actor)

static func join(left: PotionData, right: PotionData) -> JoinStatus:
	
	if not left or not right:
		return JoinStatus.generate(
			JoinStatus.Status.DISALLOWED,
			null
		)
	
	var new_potion: PotionData = PotionData.new()
	
	for left_effect: PotionEffect in left.effects:
		for right_effect: PotionEffect in right.effects:
			
			if left_effect.id == right_effect.id:
				new_potion.add_effect(left_effect)
				continue
			
			if not PotionEffect.is_joinable(left_effect, right_effect):
				return JoinStatus.generate(
					JoinStatus.Status.EXPLODED,
					null
				)
			
			new_potion.add_effect(left_effect)
			new_potion.add_effect(right_effect)
	
	new_potion.weight = (left.weight + right.weight) / 2
	new_potion.cooldown = (left.cooldown + right.cooldown) / 2
	
	return JoinStatus.generate(
		JoinStatus.Status.JOINED,
		new_potion
	)

func get_potion_color() -> Color:
	var color: Color = Color.BLACK
	
	for effect: PotionEffect in self.effects:
		color += effect.color
	
	if not self.effects.is_empty():
		color /= self.effects.size()
	
	color.a = 1
	
	return color

func add_effect(effect: PotionEffect) -> Error:
	
	if effect not in self.effects:
		self.effects.append(effect)
		
		effect_added.emit()
		return Error.OK
	
	return Error.ERR_ALREADY_EXISTS

func remove_effect(pos: int) -> void:
	
	pos = clamp(pos, 0, effects.size()-1)
	
	self.effects.remove_at(pos)
	effect_removed.emit()

func set_icon_effect(node: TextureRect) -> void:
	node.self_modulate = self.get_potion_color()
