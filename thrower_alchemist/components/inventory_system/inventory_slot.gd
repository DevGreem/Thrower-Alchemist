extends PanelContainer

class_name InventorySlot

signal text_changed
signal icon_changed
signal background_changed

@onready var icon_node: TextureRect = $IconNode
@onready var label: Label = $Label

@export var text: String:
	get:
		return label.text
	set(value):
		
		if value == label.text:
			return
		
		label.text = value
		text_changed.emit()

@export var icon: Texture2D:
	get:
		return icon_node.texture
	set(value):
		
		if icon_node.texture == value:
			return
		
		icon_node.texture = value
		icon_changed.emit()

@export var background: Texture2D

@export var const_size: Vector2

func _ready() -> void:
	self.custom_minimum_size = const_size
	self.custom_maximum_size = const_size

func _on_set_background() -> void:
	pass
