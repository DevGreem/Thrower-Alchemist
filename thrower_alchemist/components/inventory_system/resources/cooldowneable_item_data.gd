@tool
@abstract
extends InventoryItemData

class_name CooldowneableItemData

signal started_cooldown
signal refreshed

@export var cooldown: ResourceTimer:
	set(value):
		
		if value == cooldown:
			return
		
		if cooldown:
			_disconnect_cooldown_signals()
		
		cooldown = value
		
		if cooldown:
			_connect_cooldown_signals()

func process(delta: float) -> void:
	
	if cooldown:
		
		if not cooldown.started:
			cooldown.start()
			started_cooldown.emit()
		
		cooldown.process(delta)

func _disconnect_cooldown_signals() -> void:
	
	if cooldown.timeout.is_connected(_on_timeout):
		cooldown.timeout.disconnect(_on_timeout)

func _connect_cooldown_signals() -> void:
	
	if not cooldown.timeout.is_connected(_on_timeout):
		cooldown.timeout.connect(_on_timeout)

func _on_timeout() -> void:
	refreshed.emit()
