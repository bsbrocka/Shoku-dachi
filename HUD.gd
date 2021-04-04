extends CanvasLayer

signal start_game
signal exit_game

func show_message(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()

# show game over message for 2 secs, goes back to title screen, 
# and shows start button after 1 sec
func show_game_over():
	show_message("Game Over")
	# wait until the MessageTimer has counted down.
	yield($MessageTimer, "timeout")
	
	$Message.text = "Dodge the\nCreeps!"
	$Message.show()
	
	# make a one shot timer and wait for it to finish
	yield(get_tree().create_timer(1),"timeout")
	$StartButton.show()
	$ExitButton.show()
	
# called by main whenever score changes
func update_score(score):
	$ScoreLabel.text = str(score)

func _on_MessageTimer_timeout():
	$Message.hide()

func _on_StartButton_pressed():
	$StartButton.hide()
	$ExitButton.hide()
	emit_signal("start_game")

func _on_ExitButton_pressed():
	$StartButton.hide()
	$ExitButton.hide()
	emit_signal("exit_game")
