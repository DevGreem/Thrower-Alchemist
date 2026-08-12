extends RefCounted

class_name PotionJoinMode

enum Enum {
	ALLOW,
	DENY
}

static func as_string(value: Enum) -> String:
	return Enum.find_key(value)

static func as_enum(value: String) -> Enum:
	return Enum.get(value, -1)
