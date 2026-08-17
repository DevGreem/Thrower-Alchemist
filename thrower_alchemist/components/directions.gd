extends RefCounted

class_name Directions

enum Enum {
	LEFT,
	RIGHT,
	UP,
	DOWN
}

static func as_string(value: Enum) -> String:
	return Enum.find_key(value)

static func as_enum(value: String) -> Enum:
	return Enum.get(value, -1)

static func as_vector_2d(value: Enum) -> Vector2:
	
	if value == Enum.LEFT:
		return Vector2.LEFT
	
	if value == Enum.RIGHT:
		return Vector2.RIGHT
	
	if value == Enum.UP:
		return Vector2.UP
	
	if value == Enum.DOWN:
		return Vector2.DOWN
	
	return Vector2.ZERO
