extends RefCounted

class_name ContainerType

enum Enum {
	PROJECTILES_CONTAINER,
	EFFECTS_CONTAINER
}

static func as_string(value: Enum) -> String:
	return Enum.find_key(value)

static func as_enum(value: String) -> Enum:
	return Enum.get(value, -1)
