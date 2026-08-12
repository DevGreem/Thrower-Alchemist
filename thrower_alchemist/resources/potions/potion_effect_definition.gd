extends Resource

class_name PotionEffectDefinition

var id: StringName
var color: Color
var join_mode: PotionJoinMode.Enum = PotionJoinMode.Enum.ALLOW

func _init(_id: StringName = "", _color: Color = Color.BLACK, _join_mode: PotionJoinMode.Enum = PotionJoinMode.Enum.ALLOW) -> void:
	id = _id
	color = _color
	join_mode = _join_mode
