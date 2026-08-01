extends Node

## [parameter tag_type] must be a TagData type
func has_tag(tag_type: Variant, node: Node) -> bool:
	
	var tag_component: TagsComponent = ComponentManager.get_component(node, TagsComponent)
	
	if not tag_component:
		return false
	
	return tag_component.has_tag(tag_type)
