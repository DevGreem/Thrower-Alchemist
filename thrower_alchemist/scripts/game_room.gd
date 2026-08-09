extends Node2D

class_name GameRoom

signal completed
signal player_entered
signal player_exited

@export var auto_completed: bool = false
@export var player_detector: Area2D

var is_completed: bool = false:
	set(value):
		is_completed = value
		
		if is_completed:
			completed.emit()

func _ready() -> void:
	
	if not player_detector.body_entered.is_connected(_on_player_entered):
		player_detector.body_entered.connect(_on_player_entered)
	
	if not player_detector.body_exited.is_connected(_on_player_exited):
		player_detector.body_exited.connect(_on_player_exited)

func _on_player_entered(..._params: Array) -> void:
	player_entered.emit()

func _on_player_exited(..._params: Array) -> void:
	player_exited.emit()
