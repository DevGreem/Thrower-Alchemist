@tool
extends Node

signal load_requested
signal scene_changed
signal close_requested

var _previous_scene: String = ""
var previous_scene: String:
	get: return _previous_scene
	set(value): return

var current_scene: String = "":
	set(value):
		
		if value == current_scene:
			return
		
		_previous_scene = current_scene
		current_scene = value

var _path_to_load: String
var path_to_load: String:
	get: return _path_to_load
	set(value): return

var requested_time: float = -1.0

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	
	if Engine.is_editor_hint():
		_setup_manager()
		return
	
	current_scene = get_tree().current_scene.scene_file_path

func close_game() -> void:
	
	get_tree().quit()
	close_requested.emit()

func go_to_previous_scene() -> void:
	load_scene(previous_scene)

func reload_current_scene(min_wait_time: float = -1.0) -> void:
	
	requested_time = min_wait_time
	load_requested.emit()
	get_tree().reload_current_scene()

func _set_load_request(path: String, min_wait_time: float = -1.0) -> void:
	_path_to_load = path
	requested_time = min_wait_time
	load_requested.emit()

func load_scene(path: String, min_wait_time: float = -1.0) -> void:
	
	if not path:
		GameDebugger.debug_warning_string("ScenesManager", "Scene not provided", true)
		return
	
	if path == current_scene:
		return
	
	if min_wait_time <= 0.0:
		_set_load_request(path)
		return
	
	var error: Error = ResourceLoader.load_threaded_request(path)
	
	if error != OK:
		GameDebugger.debug_error_string("ScenesManager", "An error ocurred while loading a new scene", true)
		return
	
	_set_load_request(path, min_wait_time)
	
	GameDebugger.debug_log_string("ScenesManager", "Loading new scene...")
	
	get_tree().paused = true

func change_to_packed_scene(scene: PackedScene) -> void:
	
	current_scene = scene.resource_path
	get_tree().change_scene_to_packed(scene)
	scene_changed.emit()
	
	get_tree().paused = false

func change_to_file(path: String) -> void:
	
	var scene: PackedScene = load(path)
	
	if not scene:
		GameDebugger.debug_error_string("ScenesManager", "File " + path + " not founded")
		return
	
	change_to_packed_scene(scene)

func open_load_screen() -> void:
	
	if requested_time <= 0.0:
		change_to_file(path_to_load)
		finish_load()
		GameDebugger.debug_log_string("ScenesManager", "Loaded directly file " + path_to_load)
		return
	
	GameDebugger.debug_log_string("ScenesManager", "Changing scene to load screen")
	
	var scene: String = ProjectSettings.get_setting(
		"scene_manager/load_screen"
	) as String
	
	GameDebugger.debug_log_string("ScenesManager", "Opening load screen")
	
	if not scene:
		GameDebugger.debug_error_string("ScenesManager", "Load Screen not founded")
		return
	
	var instance: LoadingScreen = load(scene).instantiate()
	instance.load_verifier.await_time = requested_time
	
	get_tree().change_scene_to_node(instance)
	finish_load()

func finish_load() -> void:
	path_to_load = ""
	requested_time = -1.0

func _setup_manager() -> void:
	
	const load_screen_path: String = "scene_manager/load_screen"
	
	if ProjectSettings.has_setting(load_screen_path):
		return
	
	ProjectSettings.set_setting(
		load_screen_path,
		""
	)
	ProjectSettings.set_initial_value(
		load_screen_path,
		""
	)
	
	ProjectSettings.set_as_basic(
		load_screen_path,
		true
	)
	
	ProjectSettings.add_property_info(
		HintsUtilities.get_hint(
			load_screen_path,
			TYPE_STRING,
			PropertyHint.PROPERTY_HINT_FILE,
			"*.tscn"
		)
	)
	GameDebugger.debug_log_string("ScenesManager", "Added new project setting called scene_manager/load_screen")

func _get_setting(...parameters: Array) -> String:
	return "/".join(parameters)
