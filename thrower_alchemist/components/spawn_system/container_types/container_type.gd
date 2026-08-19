extends RefCounted

class_name ContainerType

enum Enum {
	ENTITIES,
	PROJECTILES,
	EFFECTS,
	STATIC
}

static func as_string(value: Enum) -> String:
	return Enum.find_key(value)

static func as_enum(value: String) -> Enum:
	return Enum.get(value, -1)
