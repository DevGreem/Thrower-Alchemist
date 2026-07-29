@tool
extends InventoryItemData

class_name PotionData

signal effect_added
signal effect_removed

@export var can_drink: bool = true
@export var can_throw: bool = true
@export var weight: float
@export var effects: Array[PotionEffect] = []

func _init() -> void:
	self.icon = preload("uid://dfgj4org13j6b")

func _validate_property(property: Dictionary) -> void:
	
	if property.name == "icon":
		property.usage |= PROPERTY_USAGE_READ_ONLY

func use(actor: Node) -> void:
	
	if not can_throw:
		return
	
	if actor is Node2D:
		var potion: PotionNode = PotionNode.generate(actor as Node2D, self)
		potion.global_position = actor.global_position
		
		EventBus.spawn_node(potion, ContainerType.Enum.PROJECTILES_CONTAINER)

func interact(actor: Node) -> void:
	
	if not can_drink:
		return
	
	if actor is Node2D:
		drink_effects(actor as Node2D)

func drink_effects(actor: Node2D) -> void:
	
	for effect: PotionEffect in effects:
		effect.drink_effect(actor)

static func join(left: PotionData, right: PotionData) -> PotionData:
	
	var new_potion: PotionData = PotionData.new()
	
	for left_effect: PotionEffect in left.effects:
		for right_effect: PotionEffect in right.effects:
			
			if left_effect.id == right_effect.id:
				continue
			
			if not PotionEffect.is_joinable(left_effect, right_effect):
				return null
			
			new_potion.add_effect(left_effect)
			new_potion.add_effect(right_effect)
	
	new_potion.reach_range = max(left.reach_range, right.reach_range)
	
	return new_potion

func get_potion_color() -> Color:
	var color: Color = Color.WHITE
	
	for effect: PotionEffect in self.effects:
		color *= effect.color
	
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
