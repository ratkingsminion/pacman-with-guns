extends Label

func _ready():
	Events.on_pill_count_changed.connect(on_pill_count_changed)

func on_pill_count_changed(new_count:int):
	text = str("Pills: ", new_count)
