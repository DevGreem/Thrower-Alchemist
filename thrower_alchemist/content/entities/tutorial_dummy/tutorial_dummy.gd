extends Node2D

class_name TutorialDummy

@export var follow_flip_component: FollowFlipComponent2D

func _ready() -> void:
	
	if not PlayerManager.player_changed.is_connected(_on_change_player):
		PlayerManager.player_changed.connect(_on_change_player)
	
	_on_change_player(null, PlayerManager.current_player)

func _on_change_player(_old: Node, new: Node) -> void:
	follow_flip_component.target = new
