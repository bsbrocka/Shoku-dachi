extends Button

export(String, FILE) var next_scene := ""

func _on_Start_Button_button_up():
	get_tree().change_scene(next_scene)
	PlayerData.reset()
