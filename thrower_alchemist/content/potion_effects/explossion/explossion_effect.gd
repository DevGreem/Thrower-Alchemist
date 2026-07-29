extends PotionEffect

class_name ExplossionEffect


func drink_effect(_actor: Node2D) -> void:
	pass

func throw_effect(actor: Node2D) -> void:
	
	var explosive_area: Node2D = load("uid://41lqrvlsghmi").instantiate()
	actor.get_tree().root.add_child(explosive_area)
	#explosive_area.queue_free()
