extends ShareableResource

class_name MaximumRange

signal max_value_changed(before: float, after: float)
signal current_value_changed(before: float, after: float)

@export var max_value: float:
	set(value):
		
		if max_value == value:
			return
		
		if value < current_value:
			current_value = value
		
		max_value_changed.emit(max_value, value)
		max_value = value

@export var current_value: float:
	set(value):
		
		if value > max_value:
			value = max_value
		
		if current_value == value:
			return
		
		current_value_changed.emit(current_value, value)
		current_value = value
