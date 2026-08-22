extends Control

class_name DieScreen

@export var animation: AnimationPlayer

func _ready() -> void:
	
	if not PlayerManager.player_died.is_connected(_on_player_died):
		PlayerManager.player_died.connect(_on_player_died)

func _on_player_died(_player: Node) -> void:
	start()

func start() -> void:
	animation.play("show")
	self.show()
