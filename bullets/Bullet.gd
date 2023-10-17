class_name Bullet
extends Node2D

@onready var raycast:RayCast2D = $RayCast2D

@export var speed_factor := 1.0
@export var non_hit_time := 0.35
@export var groups:Array[String] = [ "hittables" ]

var source:Object
var velocity:Vector2
var birth_time:int

###

func init(_source:Object, _velocity:Vector2):
	source = _source
	velocity = _velocity
	birth_time = Time.get_ticks_msec()

###

func _process(delta:float):
	position += speed_factor * velocity * delta * Walls.TILE_SIZE * 10
	if position.x < 0 or position.x > 320 or position.y < 0 or position.y > 200:
		queue_free()
	
	# TODO: set right positon of ray cast
	# TODO needed? raycast.force_raycast_update()
	var hit = raycast.get_collider()
	if hit == null: return
	if hit != source or Time.get_ticks_msec() > birth_time + non_hit_time * 1000:
		for g in groups:
			if not hit.is_in_group(g): continue
			Events.try_emit_signal_1(hit, Events.SIGNAL_HURT, source)
			queue_free()
			break
