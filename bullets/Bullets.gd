class_name Bullets
extends Node2D

###

func spawn(source:Node, bullet_scene:Resource, direction:Vector2, location:Vector2):
	var bullet := bullet_scene.instantiate() as Bullet
	call_deferred("add_child", bullet) # add_child(bullet)
	bullet.init(source, Vector2.RIGHT.rotated(direction.angle()))
	bullet.look_at(direction)
	bullet.position = location
