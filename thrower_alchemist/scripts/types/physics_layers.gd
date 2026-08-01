extends RefCounted

class_name PhysicsLayers

enum Enum {
	WORLD = 1,
	ENTITIES = 2,
	GROUND = 3,
	BULLETS = 4,
	EXPLOSSIONS = 5,
	DAMAGE_BOXES = 6,
	PLAYERS = 7,
	VISION_BLOCKERS = 8
}

static func mask(layer: Enum) -> int:
	return 1 << (layer - 1)
