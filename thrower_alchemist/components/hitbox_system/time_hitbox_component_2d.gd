extends HitboxComponent2D

class_name TimeHitboxComponent2D

@export var cooldown: float

var areas_timers: Dictionary[HurtboxComponent2D, float] = {}

func _ready() -> void:
	super._ready()
	
	if not self.area_exited.is_connected(_on_area_exited):
		self.area_exited.connect(_on_area_exited)

func _on_area_entered(area: Area2D) -> void:
	
	if area is HurtboxComponent2D:
		areas_timers.set(area, cooldown)

func _on_area_exited(area: Area2D) -> void:
	areas_timers.erase(area)

func _process(delta: float) -> void:
	
	for area: HurtboxComponent2D in areas_timers:
		areas_timers[area] -= delta
		
		if areas_timers[area] <= 0:
			area.receive_damage(damage)
			areas_timers[area] = cooldown
