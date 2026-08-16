extends InputComponent

class_name DashInput

signal dash_requested

func _input(event: InputEvent) -> void:
	
	if event.is_action_pressed("dash"):
		dash_requested.emit()
		GameDebugger.debug_log(DashInput, "Dash requested")
