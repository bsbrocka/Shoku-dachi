extends Node2D
signal pruned
signal despawned

# Declare member variables here. Examples:
var direc
var speed
var time_left

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	speed = rand_range(2, 4)
	#print(speed)
	time_left = 3
	$LifeLabel.text = str(time_left)
	direc = 1
	$TickTimer.start()
	$LifeTimer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_TickTimer_timeout():
	if direc == 1:
		$GreenBar.value += speed
		if $GreenBar.value >= 100:
			direc = -1
	else:
		$GreenBar.value -= speed
		if $GreenBar.value <= 0:
			direc = 1
	# print($GreenBar.value)

func _on_PruningCutSpotBubble_clicked():
	print($GreenBar.value)
	if $GreenBar.value > 36 and $GreenBar.value < 62:
		print("Success!")
		emit_signal("pruned", 1)
	else:
		print("Failed.")
		emit_signal("pruned", 0)
	
	# CutSpot deletes itself after!
	queue_free()


func _on_LifeTimer_timeout():
	time_left -= 1
	$LifeLabel.text = str(time_left)
	if time_left <= 0:
		emit_signal("despawned")
		queue_free()
	
