extends RigidBody2D

# speed range
export var min_speed = 170
export var max_speed = 270

func _ready():
	$AnimatedSprite.animation = "glow"

# when mob exits the screen, delete node
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func animate_pop():
	$AnimatedSprite.animation = "pop"
	$PopTimer.connect("timeout", self, "queue_free")
	$PopTimer.set_wait_time(.2)
	$PopTimer.start()
