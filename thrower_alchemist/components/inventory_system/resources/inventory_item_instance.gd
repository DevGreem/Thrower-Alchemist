extends Resource

class_name InventoryItemInstance

signal refreshed

@export var data: InventoryItemData
@export var amount: int
@export_storage var remaining_cooldown: float = -1:
	set(value):
		
		if value < 0:
			value = 0
		
		if value == remaining_cooldown:
			return
		
		remaining_cooldown = value
		_refreshed_cooldown()

func start_cooldown() -> void:
	remaining_cooldown = data.cooldown

func is_in_cooldown() -> bool:
	return remaining_cooldown != 0 or remaining_cooldown != data.cooldown

func _refreshed_cooldown() -> void:
	if remaining_cooldown == 0:
		refreshed.emit()

func use(actor: Node) -> bool:
	GameDebugger.debug_log(InventoryItemInstance, "Trying to use item")
	return _can_execute_action(data.actions.use.execute.bind(self.data, actor))
	
func interact(actor: Node) -> bool:
	GameDebugger.debug_log(InventoryItemInstance, "Trying to interact with item")
	return _can_execute_action(data.actions.interact.execute.bind(self.data, actor))

func _can_execute_action(callable: Callable) -> bool:
	
	if remaining_cooldown <= 0:
		callable.call()
		
		if remaining_cooldown == 0:
			start_cooldown()
		
		return true
	
	return false
