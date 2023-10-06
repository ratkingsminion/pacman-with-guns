class_name Pill
extends StaticBody2D

var x:int
var y:int

###

func init(x:int, y:int, tile_size:int):
	position = Vector2(0.5 + x, 0.5 + y) * tile_size
	self.x = x
	self.y = y

func collect():
	get_parent().collect(self)
