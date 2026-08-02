extends BTCondition

enum Operator {
	EQUAL,
	CONTAINS,
	GREATER_THAN,
	GREATER_THAN_OR_EQUAL,
	LESS_THAN,
	LESS_THAN_OR_EQUAL,
	NOT_EQUAL
}

@export var variable: BBArray
@export var operator: Operator
@export var value: BBVariant

func _tick(delta: float) -> Status:
	
	return Status.SUCCESS

func _make_operation() -> bool:
	
	match operator:
		Operator.EQUAL:
			return variable == value
		Operator.CONTAINS:
			return true
		Operator.GREATER_THAN:
			return variable.size()
	
	return false
