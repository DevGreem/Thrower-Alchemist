extends Node

class_name SpawnersTree

func spawn() -> void:
	
	for child: Node in get_children():
		if child is BaseSpawner:
			child.spawn()
		elif child is SpawnersTree:
			child.spawn()
