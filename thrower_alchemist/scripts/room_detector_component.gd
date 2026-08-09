extends Area2D

class_name RoomDetectorComponent

@export var room: GameRoom

func _ready() -> void:
	
	if not body_entered.is_connected(_on_player_entered):
		body_entered.connect(_on_player_entered)

func _on_player_entered(_body: Node2D) -> void:
	RoomManager.start_room(room)
