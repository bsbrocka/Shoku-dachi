extends Node2D
signal sunlight_won
signal sunlight_lost

export (PackedScene) var SunlightSunlight
export (PackedScene) var SunlightFly

var score
var remaining_time
var win_status

func _ready():
	randomize()
	#new_game()
	
func add_sunlight_point(_body):
	score += 1
	if score % 5 == 0:
		$Points5.play()
	else:
		$SunPop.play()
	# we still have to delete the sunlight immediately
	$SunlightHUD.update_score(score)

func minus_sunlight_point(_body):
	if score > 0:
		score -= 1
	$MinusPoint.play()
	# we still have to delete the sunlight immediately
	$SunlightHUD.update_score(score)
	
func end_game_calculation():
	if score >= 20:
		win_status = 1
		$YouWin.play()
		emit_signal("sunlight_won")
	else:
		win_status = 0
		$YouLose.play()
		emit_signal("sunlight_lost")
	game_over()
	
func game_over():
	$ScoreTimer.stop()
	$SunlightTimer.stop()
	$FlyTimer.stop()
	$SunlightHUD.show_game_over(win_status)
	# delete all mobs on screen at game over
	get_tree().call_group("suns", "queue_free")
	get_tree().call_group("flys", "queue_free")
	$SunlightPlayer.hide()
	$Music.stop()

# IMPORTANT NOTE: music is influenced by its position (surround sound)
func new_game():
	score = 0
	remaining_time = 20
	$SunlightPlayer.start($StartPosition.position)
	$StartTimer.start()
	$SunlightHUD.update_score(score)
	$SunlightHUD.show_message("Get Ready")
	$Music.play()

func exit_game():
	$SunlightHUD.scale = Vector2(0,0)
	self.visible = false

# every time sunlighttimer goes off, spawn sun
func _on_SunlightTimer_timeout():
	# choose a random location on Path2D
	$SunlightPath/SunlightSpawnLocation.offset = randi()
	# create a sunlight instance and add it to the scene
	var sunlight = SunlightSunlight.instance()
	add_child(sunlight)
	# set direction perpendicular to path direction
	var direction = $SunlightPath/SunlightSpawnLocation.rotation + PI/2
	# set position to random location
	sunlight.position = $SunlightPath/SunlightSpawnLocation.position
	# add some randomness to the direction
	direction += rand_range(-PI/4,PI/4)
	sunlight.rotation = direction
	# set the velocity (speed and direction)
	sunlight.linear_velocity = Vector2(rand_range(sunlight.min_speed,sunlight.max_speed), 0)
	sunlight.linear_velocity = sunlight.linear_velocity.rotated(direction)

# every time flytimer goes off, spawn sun
func _on_FlyTimer_timeout():
	# choose a random location on Path2D
	$FlyPath/FlySpawnLocation.offset = randi()
	# create a fly instance and add it to the scene
	var fly = SunlightFly.instance()
	add_child(fly)
	# set direction perpendicular to path direction
	var direction = $FlyPath/FlySpawnLocation.rotation + PI/2
	# set position to random location
	fly.position = $FlyPath/FlySpawnLocation.position
	# add some randomness to the direction
	direction += rand_range(-PI/4,PI/4)
	fly.rotation = direction
	# set the velocity (speed and direction)
	fly.linear_velocity = Vector2(rand_range(fly.min_speed,fly.max_speed), 0)
	fly.linear_velocity = fly.linear_velocity.rotated(direction)

func _on_ScoreTimer_timeout():
	remaining_time -= 1
	$SunlightHUD.update_time(remaining_time)
	if remaining_time <= 0:
		end_game_calculation()

# as start timer goes off, mob timer and score timer starts
func _on_StartTimer_timeout():
	$SunlightTimer.start()
	$FlyTimer.start()
	$ScoreTimer.start()

func delete_collected_sun(body):
	body.animate_pop()
