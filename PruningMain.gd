extends Node2D
signal sunlight_won
signal sunlight_lost

var score
var remaining_time
var win_status

func _ready():
	randomize()
	remaining_time = 0
	#new_game()
	
func end_game_calculation():
	if score >= 3:
		win_status = 1
		$YouWin.play()
		emit_signal("pruning_won")
	else:
		win_status = 0
		$YouLose.play()
		emit_signal("pruning_lost")
	game_over()
	
func game_over():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	$ScoreTimer.stop()
	$PruningHUD.show_game_over(win_status)
	# delete all mobs on screen at game over
	#get_tree().call_group("suns", "queue_free")
	#get_tree().call_group("flys", "queue_free")
	$PruningShears.hide()
	$PruningPlant.hide()
	$Music.stop()

# IMPORTANT NOTE: music is influenced by its position (surround sound)
func new_game():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	score = 0
	remaining_time = 20
	$PruningShears.start($StartPosition.position)
	$PruningPlant.start($StartPosition.position)
	$StartTimer.start()
	$PruningHUD.update_score(score)
	$PruningHUD.show_message("Get Ready")
	$Music.play()

func exit_game():
	$PruningHUD.scale = Vector2(0,0)
	self.visible = false

func _on_ScoreTimer_timeout():
	remaining_time -= 1
	$PruningHUD.update_time(remaining_time)
	if remaining_time <= 0:
		end_game_calculation()

# as start timer goes off, game timer starts
func _on_StartTimer_timeout():
	$ScoreTimer.start()

func _input(event):
	# Any Click
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		if event.pressed and (remaining_time > 0):
			$ShearsSound.play()
			score += 1
			$PruningHUD.update_score(score)
			
