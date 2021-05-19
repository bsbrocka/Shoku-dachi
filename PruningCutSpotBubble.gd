extends Area2D
signal clicked

func _input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		if event.pressed:
			print("Clicked")
			emit_signal("clicked")
