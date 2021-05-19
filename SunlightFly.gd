extends RigidBody2D

# speed range
export var min_speed = 200
export var max_speed = 300

func _ready():
	$AnimatedSprite.animation = "fly"

# when mob exits the screen, delete node
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func animate_pop():
	queue_free()
