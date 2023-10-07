class_name ArrayEx

static func try_get_first(array:Array, callable:Callable) -> Dictionary:
	for elem in array:
		if callable.call(elem):
			return { exists = true, elem = elem }
	return { exists = false }

static func try_get_first_index(array:Array, callable:Callable) -> Dictionary:
	for idx in array.size():
		if callable.call(array[idx]):
			return { exists = true, idx = idx }
	return { exists = false }
