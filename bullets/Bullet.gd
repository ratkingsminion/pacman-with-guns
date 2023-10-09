class_name Bullet
extends Node2D

var raycast:RayCast2D
var source:Node
var velocity:Vector2

###

func init(source:Node):
	self.source = source
	raycast = $RayCast2D as RayCast2D

###

func _process(delta:float):
	position += velocity * delta * Walls.TILE_SIZE * 10
	if position.x < 0 or position.x > 320 or position.y < 0 or position.y > 200:
		queue_free()
		
	# TODO: set right positon of ray cast
	# TODO: react to anything
	raycast.force_raycast_update()
