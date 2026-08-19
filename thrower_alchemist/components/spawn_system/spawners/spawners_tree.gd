@tool
extends ISpawn

class_name SpawnersTree

func spawn() -> void:
	
	for child: Node in get_children():
		if child is ISpawn:
			child.spawn()

func try_spawn() -> void:
	
	for child: Node in get_children():
		if child is ISpawn:
			child.try_spawn()

func despawn() -> void:
	
	for child: Node in get_children():
		if child is ISpawn:
			child.despawn()
