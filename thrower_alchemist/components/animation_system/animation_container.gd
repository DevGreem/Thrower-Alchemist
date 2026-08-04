@tool
extends Control

class_name AnimationContainer

func _ready() -> void:
	
	if not child_order_changed.is_connected(_on_order_changed):
		child_order_changed.connect(_on_order_changed)

func _on_order_changed() -> void:
	
	var rect: Rect2 = Rect2()
	
	for child: Node in get_children():
		if child is Control:
			var r: Rect2 = Rect2(child.position as Vector2, child.size as Vector2)
			
			if rect.size == Vector2.ZERO:
				rect = r
				continue
			
			rect = rect.merge(r)

	custom_minimum_size = rect.size
	GameDebugger.debug_log(AnimationContainer, "Updated custom minimum size to = " + str(custom_minimum_size))
