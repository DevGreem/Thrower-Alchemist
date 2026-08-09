@tool
extends TriggerNode

class_name TriggerSpawner

@export var spawner: BaseSpawner
@export var spawn: bool = true

func _execute(..._parameters: Array) -> void:
	GameDebugger.debug_log(TriggerSpawner, 'Executing spawner "' + str(spawner.name) + '"')
	
	if spawn:
		spawner.try_spawn()
	else:
		spawner.despawn()
