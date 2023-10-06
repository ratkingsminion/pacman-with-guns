extends Node

func move_toward(start:Vector2, end:Vector2, delta:float) -> Vector2:
	var l = (end - start)
	if l.length() < delta: return start + l
	return start + l.normalized() * delta
