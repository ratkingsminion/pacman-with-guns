extends Label

###

func _init():
	Events.on_pill_count_changed.connect(on_pill_count_changed)

func on_pill_count_changed(new_count:int, collected_count:int):
	text = str("Pills: ", new_count, " Collected: ", collected_count)
