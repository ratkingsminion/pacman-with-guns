class_name WeaponComp
extends Node

@export var bullet_scene:PackedScene
@export var shoot_seconds := 0.35

@onready var creature:Character = get_parent()

@onready var bullets:Bullets = $/root/Main/GAME/BULLETS

var shoot_timer:float

###

func try_shoot(dir:Vector2) -> bool:
	if shoot_timer > Time.get_ticks_msec() / 1000.0: return false
	if creature.cur_dir.x != 0 and fposmod(creature.position.y, 1.0) != 0.0: return false
	if creature.cur_dir.y != 0 and fposmod(creature.position.x, 1.0) != 0.0: return false
	shoot_timer = Time.get_ticks_msec() / 1000.0 + shoot_seconds
	bullets.spawn(creature, bullet_scene, dir, creature.position)
	return true
