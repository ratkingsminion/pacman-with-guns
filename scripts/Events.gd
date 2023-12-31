extends Node

### non targeted signals

signal pill_count_changed(new_count:int, collected_count:int)

### targeted signal ids

const SIGNAL_HURT = "hurt"		# arguments: source
const SIGNAL_DIE = "die"		# arguments:

### usage of targeted signals

func add_signal(target:Object, signal_id:String, callable:Callable) -> bool:
	if target == null or callable == null: return false
	if not target.has_user_signal(signal_id): target.add_user_signal(signal_id)
	target.connect(signal_id, callable)
	return true

func try_emit_signal(target:Object, signal_id:String) -> bool:
	if target == null or not target.has_user_signal(signal_id): return false
	target.emit_signal(signal_id)
	return true

func try_emit_signal_1(target:Object, signal_id:String, a) -> bool:
	if target == null or not target.has_user_signal(signal_id): return false
	target.emit_signal(signal_id, a)
	return true

func try_emit_signal_2(target:Object, signal_id:String, a, b) -> bool:
	if target == null or not target.has_user_signal(signal_id): return false
	target.emit_signal(signal_id, a, b)
	return true
