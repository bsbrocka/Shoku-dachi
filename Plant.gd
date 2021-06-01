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
	"res://livespace_assets/office_bg.png",
	"res://livespace_assets/space_bg.png"
]

var plant = ["Alocasia", "Aloe"]
var bow_scale = [1.5,2.5]
var glasses_scale = [2,3.5]
var bow_pos = [[248,660],[185,575]]
var glasses_pos = [[248,618],[250,645]]

var acc = [
	"res://Shop/bows/bow_red.png",
	"res://Shop/bows/bow_blue.png",
	"res://Shop/bows/bow_yellow.png",
	"res://Shop/glasses/glasses_round.png",
	"res://Shop/glasses/glasses_shades.png",
]

# 1 second delay
var plant_time = [61,121]
var plant_currency = [20,50] 

func update_currency():
	$MainHUD/Counter/Background/Number.text = str(Global.currency)

func _ready():
	Global.load_currency()
	update_currency()
	$AnimatedSprite.play()
	
	time = plant_time[Global.shop.selected[0]]
	bar.max_value = time - 1
	Global.load_time()
	var curr_time = OS.get_unix_time()
	
	if Global.last_collect != 0:
		time = max(1,time + Global.last_collect - curr_time)
		bar.value = plant_time[Global.shop.selected[0]] - time
		if time == 1:
			bar.value = bar.max_value
	
	bar_time = time - 1
	
	number_label.text = time_remaining
	time_running = true
	$BarProgress.start()
	
	$AnimatedSprite.play(plant[Global.shop.selected[0]])
	$background.texture = load(bg[Global.shop.selected[2]])
	_on_Shop_update_acc()
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
		Global.last_collect = OS.get_unix_time()
		update_currency()
		Global.save_currency()
		Global.save_time()
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

func _on_Shop_update_acc():
	var plant_idx = Global.shop.selected[0]
	var acc_idx = Global.shop.selected[1]
	
	if acc_idx == 0:
		$Bow.hide()
		$Glasses.hide()
	elif acc_idx <= 3:
		$Glasses.hide()
		$Bow.texture = load(acc[acc_idx - 1])
		$Bow.scale = Vector2(bow_scale[plant_idx],bow_scale[plant_idx])
		$Bow.position.x = bow_pos[plant_idx][0]
		$Bow.position.y = bow_pos[plant_idx][1]
		$Bow.show()
	else:
		$Bow.hide()
		$Glasses.texture = load(acc[acc_idx - 1])
		$Glasses.scale = Vector2(glasses_scale[plant_idx],glasses_scale[plant_idx])
		$Glasses.position.x = glasses_pos[plant_idx][0]
		$Glasses.position.y = glasses_pos[plant_idx][1]
		$Glasses.show() 

func _on_sunlight_minigame_won():
	Global.currency += 15
	update_currency()
	
func _on_pruning_minigame_won():
	Global.currency += 10
	update_currency()
	
func _on_watering_minigame_won():
	Global.currency += 20
	update_currency()
