@tool
extends Node

signal change_requested
@warning_ignore("unused_signal")
signal scene_changed

const GROUP_SETTING: String = "scene_manager"
const LOAD_SCREEN_SETTING: String = "load_screen"

var current_scene: String = ""
var previous_scene: String = ""

func _ready() -> void:
	
	if Engine.is_editor_hint():
		_setup_manager()
		return

func change_scene(path: String) -> void:
	
	if path == current_scene:
		return
	
	change_requested.emit()
	
	var error: Error = ResourceLoader.load_threaded_request(path)
	
	if error != OK:
		GameDebugger.debug_error_string("Scene Manager", "An error ocurred while loading a new scene", true)
		return
	
	previous_scene = current_scene
	current_scene = path

func open_load_screen() -> void:
	
	get_tree().change_scene_to_file(
		ProjectSettings.get_setting(
			_get_setting(GROUP_SETTING, LOAD_SCREEN_SETTING)
		) as String
	)

func _setup_manager() -> void:
	
	if ProjectSettings.has_setting("scene_manager/load_screen"):
		return
	
	var load_screen_path: String = _get_setting(GROUP_SETTING, LOAD_SCREEN_SETTING)
	
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
	GameDebugger.debug_log_string("SceneManager", "Added new project setting called scene_manager/load_screen")

func _get_setting(...parameters: Array) -> String:
	return "/".join(parameters)
