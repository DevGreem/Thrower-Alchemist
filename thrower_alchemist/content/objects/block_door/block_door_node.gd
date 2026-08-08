extends Node2D

class_name BlockDoorNode

signal opened
signal closed

func open() -> void:
	opened.emit()

func close() -> void:
	closed.emit()
