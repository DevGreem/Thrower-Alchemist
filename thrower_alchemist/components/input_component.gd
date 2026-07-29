extends Node

class_name InputComponent

@export var actor: Node2D
@export var action: String

var function: Callable

func _input(event: InputEvent) -> void:
	
	if event.is_action(action) and event.is_pressed():
		#function.call()
		
		var potion: PotionNode = preload("uid://dmr3imp88ys2").instantiate()
		potion.data = preload("uid://cbndbhn3tf5bt").duplicate_deep(Resource.DEEP_DUPLICATE_ALL)
		potion.actor = actor
		print(potion.data.to_dict())
		potion.global_position = actor.global_position
		get_tree().root.add_child(potion)
