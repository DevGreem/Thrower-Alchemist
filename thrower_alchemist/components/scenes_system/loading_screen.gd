extends Control

class_name LoadingScreen

@export var load_verifier: SceneLoadVerifierNode

static func open(scene: PackedScene, min_wait_time: float = -1.0) -> LoadingScreen:
	
	var instance: LoadingScreen = scene.instantiate()
	instance.load_verifier.await_time = min_wait_time
	
	return instance
