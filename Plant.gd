extends Area2D

var bar_time

var time = 0
var time_running = false
var time_remaining = ""

onready var number_label = $Bar/Count/Background/Number
onready var bar = $Bar/Gauge

var bg = [
	"res://livespace_assets/outdoor_background.png",
	"res://livespace_assets/office_bg_2.png",
	"res://livespace_assets/office_bg.png"
]

var plant = ["Alocasia", "Aloe"]
# 1 second delay
var plant_time = [11,21]
var plant_currency = [20,50] 

func update_currency():
	$MainHUD/Counter/Background/Number.text = str(Global.currency)

func _ready():
	Global.load_currency()
	update_currency()
	$AnimatedSprite.play()
	time = plant_time[Global.shop.selected[0]]
	bar.max_value = time - 1
	bar_time = time - 1
	number_label.text = time_remaining
	time_running = true
	$BarProgress.start()
	
	$AnimatedSprite.play(plant[Global.shop.selected[0]])
	$background.texture = load(bg[Global.shop.selected[2]])
	$MainScreenMusic.play()

func _input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton \
	and event.button_index == BUTTON_LEFT \
	and event.is_pressed():
		self.on_click()
		
func on_click():
	print("Click")

func reset_timer():
	time = plant_time[Global.shop.selected[0]]
	bar.max_value = time - 1
	bar_time = time - 1
	number_label.text = str(time_remaining)
	time_running = true
	bar.value = 0
	$BarProgress.start()

func collect():
	if time_remaining != "Ready!":
		pass
	else:
		Global.currency += plant_currency[Global.shop.selected[0]]
		print(Global.currency)
		update_currency()
		Global.save_currency()
		reset_timer()

func _process(delta):
	if time_running == true:
		time -= delta
	
	var secs = fmod(time,60)
	var mins = fmod(time,3600) / 60
	
	time_remaining = "%02dm %02ds" % [mins, secs]
	number_label.text = time_remaining
	if time_remaining == "00m 00s":
		time_remaining = "Ready!"
		number_label.text = time_remaining
		time_running = false

func _on_BarProgress_timeout():
	bar_time -= 1
	if bar_time <= 0:
		$BarProgress.stop()
	bar.value += 1

func _on_Shop_purchase():
	update_currency()
	Global.save_currency()

func _on_Shop_update_bg():
	$background.texture = load(bg[Global.shop.selected[2]])

func _on_Shop_update_plant():
	$AnimatedSprite.play(plant[Global.shop.selected[0]])
	reset_timer()

