class_name HealthComp
extends Node

@export var max_halth := 5

@onready var creature:Creature = get_parent()
@onready var sprite:Sprite2D = $".."/Sprite2D

var health := 0
var tween:Tween
var scale_start:Vector2

###

func _ready():
	health = max_halth
	Events.add_signal(creature, Events.SIGNAL_HURT, on_hurt)
	scale_start = sprite.scale

### events:

func on_hurt(source):
	if health <= 0: return # already dead
	
	health -= 1
	if health <= 0:
		die()
	else:
		if tween != null: tween.stop()
		sprite.scale = scale_start * 1.5
		sprite.modulate = Color.RED
		tween = get_tree().create_tween()
		tween.parallel().tween_property(sprite, "modulate", Color.WHITE, 0.1)
		tween.parallel().tween_property(sprite, "scale", scale_start, 0.1)

###

func die():
	health = 0
	Events.try_emit_signal(creature, Events.SIGNAL_DIE)
