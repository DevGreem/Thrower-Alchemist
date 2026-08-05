extends Resource

class_name JoinStatus

enum Status {
	DISALLOWED,
	EXPLODED,
	JOINED
}

var status: Status
var result: PotionData = null

static func generate(_status: Status, _result: PotionData) -> JoinStatus:
	
	var instance: JoinStatus = JoinStatus.new()
	instance.status = _status
	instance.result = _result
	
	return instance
