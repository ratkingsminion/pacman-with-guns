class_name Bullet
extends Node2D

var raycast:RayCast2D
var source:Object
var velocity:Vector2

###

func init(source:Object):
	self.source = source
	raycast = $RayCast2D

###

func _process(delta:float):
	position += velocity * delta * Walls.TILE_SIZE * 10
	if position.x < 0 or position.x > 320 or position.y < 0 or position.y > 200:
		queue_free()
		
	# TODO: set right positon of ray cast
	# TODO needed? raycast.force_raycast_update()
	var hit = raycast.get_collider()
	if hit != null and hit.is_in_group("hittable"):
		# TODO: has_user_signal("on_hurt")
		#emit_signal("test", )
		#hit.queue_free()
		Events.try_emit_signal_1(hit, Events.SIGNAL_HURT, source)
		#if hit.has_user_signal("on_hurt"):
		#	hit.emit_signal("on_hurt", "BY BULLET")
		queue_free()
