extends CanvasLayer
signal start_game
signal restart
signal exit
func _ready():
	$"title".hide()
	#$VboxContainer.hide()
	$VBoxContainer2.hide()
	$TextureRect.hide()
	$VBoxContainer2.hide()
	
func start_screen_show():
	$title.text="CATCH WATER"
	$"title".show()
	$VBoxContainer.show()
	$TextureRect.show()

func _on_Start_Button_button_up():
	$"title".hide()
	$"VBoxContainer/StartButton".hide()
	$"VBoxContainer/ExitButton".hide()
	$VBoxContainer2.hide()
	$TextureRect.hide()
	emit_signal("start_game")


func _on_Exit_Button_button_up():
	#get_tree().quit()
	emit_signal("exit")

func final_score(score):
	$title.text=str(score)
func _on_Main_game_over():
	$title.show()
	$VBoxContainer2.show()
	$TextureRect.show()

func _on_restart_button_up():
	$"title".hide()
	$VBoxContainer2.hide()
	$TextureRect.hide()
	$"VBoxContainer/StartButton".hide()
	$"VBoxContainer/ExitButton".hide()
	#get_tree().change_scene("res://wateringmain.tscn")
	emit_signal("restart")
	
