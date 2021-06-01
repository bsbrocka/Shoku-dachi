extends CanvasLayer
signal start_game
signal restart
signal exit
func _ready():
	$message.hide()
	$"title".hide()
	#$VboxContainer.hide()
	$VBoxContainer2.hide()
	$TextureRect.hide()
	$VBoxContainer2.hide()
	
func start_screen_show():
	$message.hide()
	$title.text="Collect 7 Droplets"
	$"title".show()
	$VBoxContainer.show()
	$TextureRect.show()

func _on_Start_Button_button_up():
	$message.hide()
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
	$message.show()
func _on_restart_button_up():
	$message.hide()
	$"title".hide()
	$VBoxContainer2.hide()
	$TextureRect.hide()
	$"VBoxContainer/StartButton".hide()
	$"VBoxContainer/ExitButton".hide()
	#get_tree().change_scene("res://wateringmain.tscn")
	emit_signal("restart")
	
func _on_Main_lose():
	$message.text=str("You lose!")
	
func _on_Main_win():
	$message.text=str("You win!")
