class_name Bullets
extends Node2D

@export var bullet_scenes:Array[PackedScene]

###

func spawn(bullet_name:String, source:Node, direction:Vector2, location:Vector2) -> Bullet:
	var bullet_scene := ArrayEx.try_get_first(bullet_scenes, func(bs): return bs.resource_path.contains(bullet_name))
	if not bullet_scene.exists: return null
	var bullet:Bullet = bullet_scene.elem.instantiate()
	call_deferred("add_child", bullet) # add_child(bullet)
	bullet.init(source, Vector2.RIGHT.rotated(direction.angle()))
	bullet.look_at(direction)
	bullet.position = location
	return bullet
