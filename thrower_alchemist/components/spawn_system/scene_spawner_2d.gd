@tool
extends BaseSpawner

class_name SceneSpawner2D

@export var scene: PackedScene:
	set(value):
		scene = value
		notify_property_list_changed()

func spawn() -> void:
	spawned_node = EventBus.spawn_scene(
		scene,
		self.global_position,
		spawn_container
	)
