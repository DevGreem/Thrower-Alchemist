extends Node

signal player_spawned(player: PlayerNode)

@warning_ignore("unused_signal")
signal player_died(player: PlayerNode)
signal player_changed(old: PlayerNode, new: PlayerNode)

var current_player: PlayerNode = null:
	set(value):
		
		if current_player == value:
			return
		
		player_changed.emit(current_player, value)
		current_player = value

func _ready() -> void:
	
	if not player_spawned.is_connected(_on_spawn_player):
		player_spawned.connect(_on_spawn_player)
	
	if not player_died.is_connected(_on_die_player):
		player_died.connect(_on_die_player)

func _on_spawn_player(player: PlayerNode) -> void:
	GameDebugger.debug_log_string("PlayerManager", "Player " + str(player) + " spawned")
	current_player = player

func _on_die_player(_player: PlayerNode) -> void:
	GameDebugger.debug_log_string("PlayerManager", "Player died")
	current_player = null
