extends Node2D

class_name DoorsContainer

func close() -> void:
	
	for door: Node in self.get_children():
		
		if door.has_method(&"close"):
			door.close()

func open() -> void:
	
	for door: Node in self.get_children():
		
		if door.has_method(&"open"):
			door.open()
