extends RigidBody2D

# speed range
export var min_speed = 150
export var max_speed = 250

func _ready():
	# randomly choose one of the three mobs to spawn
	var mob_types = $AnimatedSprite.frames.get_animation_names()
	$AnimatedSprite.animation = mob_types[randi() % mob_types.size()]

# when mob exits the screen, delete node
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
