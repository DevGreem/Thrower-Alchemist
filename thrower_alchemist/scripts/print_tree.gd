@tool
extends EditorScript

func _run() -> void:
	_print_tree(get_scene())

func _print_tree(node: Node, indent: String = "") -> void:
	print(indent, node.name, " (", node.get_class(), ")")
	
	for child: Node in node.get_children():
		_print_tree(child, indent + "	")
