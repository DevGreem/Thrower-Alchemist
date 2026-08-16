@tool
extends TriggerNode

class_name TriggerSpawner

@export var spawner: ISpawn
@export var spawn: bool = true

func execute(..._parameters: Array) -> void:
	GameDebugger.debug_log(TriggerSpawner, 'Executing spawner "' + str(spawner.name) + '"')
	
	if spawn:
		spawner.try_spawn()
	else:
		spawner.despawn()
