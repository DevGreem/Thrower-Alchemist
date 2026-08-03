extends Panel

class_name MixerSlot

signal pressed

var ui_manager: PotionMixerUI
@export var potion_icon: PotionIconComponent

func _gui_input(event: InputEvent) -> void:
	
	if event is InputEventMouseButton:
		
		if not event.pressed:
			return
		
		if event.button_index == MOUSE_BUTTON_LEFT:
			GameDebugger.debug_log(MixerSlot, "Clicked slot " + str(self))
			pressed.emit()
