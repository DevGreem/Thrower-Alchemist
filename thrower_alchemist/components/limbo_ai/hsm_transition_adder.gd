@tool
extends BaseHSMTransitionAdder

class_name HSMTransitionAdder

func trigger() -> void:
	GameDebugger.debug_log(HSMTransitionAdder, "Executing transition to " + to_state.name)
	state_machine.dispatch(transition_name)
	triggered.emit()
