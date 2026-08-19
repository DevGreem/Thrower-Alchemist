extends Node

class_name SceneLoadVerifierNode

@export var await_time: float = 1.0

func _ready() -> void:
	await_time = ScenesManager.load_min_wait_time

func _process(delta: float) -> void:
	
	if await_time >= 0.0:
		await_time -= delta
		return
	
	var status: ResourceLoader.ThreadLoadStatus = ResourceLoader.load_threaded_get_status(ScenesManager.current_scene)
	
	if status == ResourceLoader.THREAD_LOAD_FAILED:
		ScenesManager.go_to_previous_scene()
		GameDebugger.debug_error(SceneLoadVerifierNode, "Scene thread load failed\nScene: " + ScenesManager.current_scene)
		return
	
	if status == ResourceLoader.THREAD_LOAD_INVALID_RESOURCE:
		ScenesManager.go_to_previous_scene()
		GameDebugger.debug_error(SceneLoadVerifierNode, "Invalid scene\nPath: " + ScenesManager.current_scene)
	
	if status != ResourceLoader.THREAD_LOAD_LOADED:
		return
	
	var scene: PackedScene = ResourceLoader.load_threaded_get(ScenesManager.current_scene)
	ScenesManager.change_to_packed_scene(scene)
