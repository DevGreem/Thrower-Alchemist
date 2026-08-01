extends Node

class_name TagsComponent

@export var tags: Array[TagData] = []

## [parameter tag_type] tag_type is a type of TagData
func has_tag(tag_type: Variant) -> bool:
	
	for tag: TagData in tags:
		if is_instance_of(tag, tag_type):
			return true
	
	return false

func has_tag_by_id(tag_id: StringName) -> bool:
	
	for tag: TagData in tags:
		if tag.id == tag_id:
			return true
	
	return false
