class_name Pill
extends StaticBody2D

var coords:Vector2i

###

func init(x:int, y:int, tile_size:int):
	position = Vector2(0.5 + x, 0.5 + y) * tile_size
	coords = Vector2i(x, y)

func collect():
	get_parent().collect(self)
