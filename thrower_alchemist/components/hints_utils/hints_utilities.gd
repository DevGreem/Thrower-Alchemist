extends RefCounted

class_name HintsUtilities

static func get_hint(
	name: String,
	type: Variant.Type,
	hint: PropertyHint,
	hint_string: String
) -> Dictionary:
	return {
		"name": name,
		"type": type,
		"hint": hint,
		"hint_string": hint_string
	}
