extends Area2D

class_name InteractionArea2D

@export var action_name: String = "interact"
@export var active: bool = true

var interact: Callable = func() -> void: pass

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
