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
	health -= 1
	if health <= 0:
		die()
	else:	
		var tween = get_tree().create_tween()
		tween.parallel().tween_property($".."/Sprite2D, "modulate", Color.RED, 0.1)
		tween.parallel().tween_property($".."/Sprite2D, "scale", Vector2.ZERO, 0.1)
		tween.tween_callback(func(): $".."/Sprite2D.scale = Vector2.ONE)
		print(tween)

###

func die():
	creature.queue_free()
