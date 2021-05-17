extends Button

#export(String, FILE) var next_scene := ""

func _on_Start_Button_button_up():
	get_tree().change_scene("res://source/Levels/Level.tscn")
	PlayerData.reset()
