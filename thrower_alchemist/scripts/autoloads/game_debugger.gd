extends Node

func debug(message: String, force_show: bool = false, type: DebugType.Enum = DebugType.Enum.LOG) -> void:
	
	if type == DebugType.Enum.LOG:
		debug_log(message, force_show)
	elif type == DebugType.Enum.WARNING:
		debug_warning(message, force_show)
	elif type == DebugType.Enum.ERROR:
		debug_error(message, force_show)

func debug_log(message: String, force_show: bool = false) -> void:
	
	if OS.is_debug_build() or force_show:
		print(message)

func debug_warning(message: String, force_show: bool = false) -> void:
	
	if OS.is_debug_build() or force_show:
		push_warning(message)

func debug_error(message: String, force_show: bool = false) -> void:
	
	if OS.is_debug_build() or force_show:
		push_error(message)
