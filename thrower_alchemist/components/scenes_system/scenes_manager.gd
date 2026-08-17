@tool
extends Node

signal change_requested
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

func _ready() -> void:
	
	if Engine.is_editor_hint():
		_setup_manager()
		return
	
	current_scene = ProjectSettings.get_setting("application/run/main_scene")

func close_game() -> void:
	
	get_tree().quit()
	close_requested.emit()

func go_to_previous_scene() -> void:
	change_scene(previous_scene)

func change_scene(path: String) -> void:
	
	if not path:
		GameDebugger.debug_warning_string("ScenesManager", "Scene not proportioned", true)
		return
	
	if path == current_scene:
		return
	
	var error: Error = ResourceLoader.load_threaded_request(path)
	
	if error != OK:
		GameDebugger.debug_error_string("ScenesManager", "An error ocurred while loading a new scene", true)
		return
	
	change_requested.emit()
	
	GameDebugger.debug_log_string("ScenesManager", "Loading new scene...")
	
	get_tree().paused = true
	current_scene = path

func change_to_packed_scene(scene: PackedScene) -> void:
	
	scene_changed.emit()
	get_tree().change_scene_to_packed(scene)
	
	get_tree().paused = false

func open_load_screen() -> bool:
	GameDebugger.debug_log_string("ScenesManager", "Changing scene to load screen")
	
	var scene: String = ProjectSettings.get_setting(
		"scene_manager/load_screen"
	) as String
	
	if not scene:
		GameDebugger.debug_error_string("ScenesManager", "Load screen not founded", true)
		scene_changed.emit()
		return false
	
	get_tree().change_scene_to_file(scene)
	return true

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
