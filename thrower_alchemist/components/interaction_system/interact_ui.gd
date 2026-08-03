extends CanvasItem

class_name InteractUI

@export var interact_component: InteractComponent2D

func _ready() -> void:
	
	if not interact_component:
		return
	
	if not interact_component.focused_interactable_changed.is_connected(toggle_visibility):
		interact_component.focused_interactable_changed.connect(toggle_visibility)
	
func toggle_visibility(area: InteractArea2D) -> void:
	
	if not interact_component or not area:
		self.hide()
		return
	
	if not area.active or not interact_component.can_interact:
		self.hide()
		return
	
	self.show()

func _connect_to_interactable(area: InteractArea2D) -> void:
	
	if not area.status_changed.is_connected(toggle_visibility.bind(area)):
		area.status_changed.connect(toggle_visibility.bind(area))
