extends Area2D

var collect_time = 20
var currency = 0
var curr_time

onready var number_label = $Bar/Count/Background/Number
onready var bar = $Bar/Gauge
onready var tween = $Tween

func _ready():
	$AnimatedSprite.play()
	bar.max_value = collect_time
	curr_time = collect_time
	number_label.text = str(curr_time)
	$CollectTimer.start()

func _input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton \
	and event.button_index == BUTTON_LEFT \
	and event.is_pressed():
		self.on_click()
		
func on_click():
	print("Click")

func _on_CollectTimer_timeout():
	curr_time -= 1
	number_label.text = str(curr_time)
	if curr_time <= 0:
		$CollectTimer.stop()
	bar.value += 1

func collect():
	if curr_time > 0:
		pass
	else:
		currency += 20
		$Counter/Background/Number.text = str(currency)
		timer_reset()

func timer_reset():
	curr_time = collect_time
	number_label.text = str(curr_time)
	bar.value = 0
	$CollectTimer.start()
	
