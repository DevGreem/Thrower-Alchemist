@abstract
extends Node

class_name AudioRequester

signal play_requested

@abstract
func _request_play() -> void

func request_play() -> void:
	_request_play()
	play_requested.emit()
