extends FollowNodeComponent2D

class_name FollowPlayerComponent2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	if not PlayerManager.player_changed.is_connected(_on_player_changed):
		PlayerManager.player_changed.connect(_on_player_changed)
	
	if is_instance_valid(PlayerManager.current_player):
		_on_player_changed(null, PlayerManager.current_player)

func _on_player_changed(_old: Node, new: Node) -> void:
	self.target = new

func _validate_property(property: Dictionary) -> void:
	
	if property.name == "target":
		property.usage = PROPERTY_USAGE_NO_EDITOR
