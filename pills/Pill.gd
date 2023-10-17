class_name Pill
extends Area2D

var coords:Vector2i
@onready var player := $/root.find_child("Player", true, false)

###

func init(x:int, y:int, tile_size:int):
	position = Vector2(0.5 + x, 0.5 + y) * tile_size
	coords = Vector2i(x, y)
	body_shape_entered.connect(_on_body_shape_entered) # for collecting pills

### events

func _on_body_shape_entered(_body_rid:RID, body:Node2D, _body_shape_index:int, _local_shape_index:int):
	if body == player: # TODO
		get_parent().collect(self)
