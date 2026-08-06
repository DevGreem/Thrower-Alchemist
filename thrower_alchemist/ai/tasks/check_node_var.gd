extends BTCondition

@export var node: NodePath
@export var property: StringName
@export_enum('==', '!=', ">=", "<=", ">", "<", "and", "or") var check_type: String
@export var value: Variant

func _tick(_delta: float) -> Status:
	
	var expression: Expression = Expression.new()
	
	var comparation: String = "property " + check_type + " value"
	
	var error: Error = expression.parse(comparation, ["property", "value"])
	
	if error != Error.OK:
		return Status.FAILURE
	
	var prop_val: Variant = scene_root.get_node(node).get(property)
	
	var answer: Variant = expression.execute([
		prop_val,
		value
	])
	
	if expression.has_execute_failed():
		return Status.FAILURE
	
	var result: bool = answer
	
	if result:
		return Status.SUCCESS
	
	return Status.FAILURE
