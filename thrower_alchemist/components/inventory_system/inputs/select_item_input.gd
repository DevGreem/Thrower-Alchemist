extends InputComponent

class_name SelectItemInput

@export var hotbar_component: HotbarComponent

func _input(event: InputEvent) -> void:
	
	if event is InputEventKey:
		if event.keycode >= Key.KEY_0 and event.keycode <= Key.KEY_9 and event.pressed:
			var idx: int = event.keycode - Key.KEY_1
			
			hotbar_component.item_selected = idx
