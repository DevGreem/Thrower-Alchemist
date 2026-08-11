@tool
extends TriggerNode

class_name TriggersTree

func execute(..._parameters: Array) -> void:
	
	for child: Node in get_children():
		
		if child is ITrigger:
			child.execute()

func _get_configuration_warnings() -> PackedStringArray:
	
	var warnings: PackedStringArray = super._get_configuration_warnings()
	
	if get_child_count() == 0:
		warnings.append("This trigger never will execute any action")
	
	return warnings
