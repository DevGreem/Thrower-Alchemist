extends Entity

class_name PlayerNode

@onready var health_component: HealthComponent = $HealthComponent

func _ready() -> void:
	PlayerManager.player_spawned.emit(self)
	
	if not health_component.died.is_connected(_on_die):
		health_component.died.connect(_on_die)

func _on_die() -> void:
	PlayerManager.player_died.emit(self)
	self.queue_free()
