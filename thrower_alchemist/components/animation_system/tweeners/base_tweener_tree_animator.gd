@abstract
@tool
extends TweenerAnimator

class_name BaseTweenerTreeAnimator

var animations: Array[TweenerAnimator] = []

func _ready() -> void:
	update_childrens()

func update_childrens() -> void:
	
	animations.clear()
	
	for child: Node in get_children():
		if child is TweenerAnimator:
			animations.append(child)
