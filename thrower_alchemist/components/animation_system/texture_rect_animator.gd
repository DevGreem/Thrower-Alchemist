@tool
extends Node

class_name TextureRectAnimator

@export var target: TextureRect
@export var columns: int = 1
@export var rows: int = 1
@export var fps: float = 1.0

@export var _start_frame: int = 0

var frame: int = 0
var _counter: float = 0.0

func _ready() -> void:
	
	frame = _start_frame
	_update_frame()

func _process(delta: float) -> void:
	
	if not target:
		return
	
	_counter += delta
	
	if _counter >= 1.0 / fps:
		_counter -= 1.0 / fps
		
		frame = (frame + 1) % (columns * rows)
		_update_frame()

func _update_frame() -> void:
	
	if not target:
		return
	
	if not target.texture:
		return
	
	var texture: AtlasTexture = target.texture
	
	var frame_size: Vector2 = texture.atlas.get_size() / Vector2(columns, rows)
	
	var column: int = frame % columns
	var row: int = int(float(frame) / float(columns))
	
	var region: Rect2 = Rect2(
		Vector2(column, row) * frame_size,
		frame_size
	)
	
	texture.region = region
	
func _get_configuration_warnings() -> PackedStringArray:
	
	var warnings: PackedStringArray = []
	
	if not target:
		return []
	
	if target.texture is not AtlasTexture:
		warnings.append("The texture of must be an atlas texture!")
	
	return warnings
