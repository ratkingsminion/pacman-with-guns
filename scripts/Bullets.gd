class_name Bullets
extends Node2D

###

func _init():
	Events.on_player_try_shoot.connect(on_player_try_shoot)

func on_player_try_shoot(bullet_scene:Resource, direction:Vector2, location:Vector2):
	var bullet := bullet_scene.instantiate() as Node2D
	add_child(bullet)
	bullet.look_at(direction)
	bullet.position = location
	bullet.velocity = Vector2.RIGHT.rotated(bullet.rotation)