extends CanvasItem

class_name ToggleGameHideUtilNode

@export var hide_in_game: bool = true

func _ready() -> void:
	
	if hide_in_game:
		self.hide()
	else:
		self.show()
