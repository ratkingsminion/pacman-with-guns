class_name HealthComp
extends Node

@export var max_halth := 5

@onready var creature:Character = get_parent()

var health := 0

###

func _ready():
	health = max_halth
	Events.add_signal(creature, Events.SIGNAL_HURT, on_hurt)

### events:

func on_hurt(source):
	if health <= 0: return # already dead
	
	health -= 1
	if health <= 0:
		die()
	else:
		var sprite := $".."/Sprite2D as Sprite2D # TODO: change method of retrieving GFX
		var scale_start := sprite.scale
		sprite.scale = scale_start * 1.5
		sprite.modulate = Color.RED
		var tween = get_tree().create_tween()
		tween.parallel().tween_property(sprite, "modulate", Color.WHITE, 0.1)
		tween.parallel().tween_property(sprite, "scale", scale_start, 0.1)

###

func die():
	health = 0
	Events.try_emit_signal(creature, Events.SIGNAL_DIE)
