extends Node2D
signal pruning_won
signal pruning_lost
signal snip
signal quick_bounce

export (PackedScene) var PruningCutSpot

var score
var remaining_time
var win_status

func _ready():
	randomize()
	remaining_time = 0
	#new_game()
	
func end_game_calculation():
	if score >= 10:
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
	get_tree().call_group("cutspots", "queue_free")
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
	#Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	score = 0
	remaining_time = 20
	$PruningShears.start($StartPosition.position)
	$PruningPlant.start($StartPosition.position)
	$StartTimer.start()
	$PruningHUD.update_score(score)
	$PruningHUD.show_message("Get Ready")
	$Music.play()
	emit_signal("quick_bounce")

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
	spawn_CutSpot()

func _input(event):
	# Audio-visual response to any click:
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		if event.pressed and (remaining_time > 0):
			$ShearsSound.play()
			emit_signal("snip")
			
func _on_PruningCutSpot_pruned(status):
	# Success, add point!
	if status == 1:
		$SuccessSound.play()
		score += 1
		$PruningHUD.update_score(score)
		emit_signal("quick_bounce")
	# Failure, 
	else:
		$FailSound.play()
	spawn_CutSpot()

func _on_PruningCutSpot_despawned():
	$DespawnSound.play()
	spawn_CutSpot()

func spawn_CutSpot():
	#$PruningPlant/CollisionShape2D.get_item_rect()
	#var centerpos = colshape2d.position + area2d.position
	#var positionInArea.x = (randi() % size.x) - (size.x/2) + centerpos.x
	#var positionInArea.y = (randi() % size.y) - (size.y/2) + centerpos.y
	if remaining_time > 0:
		var min_x = -10
		var max_x = 260
		var min_y = 110
		var max_y = 400
		var spawn = PruningCutSpot.instance()
		spawn.position.x = rand_range(min_x, max_x)
		spawn.position.y = rand_range(min_y, max_y)
		add_child(spawn)
		spawn.connect("pruned", self,"_on_PruningCutSpot_pruned")
		spawn.connect("despawned", self,"_on_PruningCutSpot_despawned")
