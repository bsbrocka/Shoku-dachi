extends Area2D
var bouncing

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
	bouncing = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func start(pos):
	show()
	$CollisionShape2D.disabled = false

func _input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton \
	and event.button_index == BUTTON_LEFT \
	and event.is_pressed():
		self.on_click()
		
func on_click():
	print("Click")

func quick_bounce():
	print("bounce!!")
	$AnimatedSprite.play()
	$BounceTimer.set_wait_time(.5)
	$BounceTimer.start()

func _on_BounceTimer_timeout():
	$AnimatedSprite.stop()
