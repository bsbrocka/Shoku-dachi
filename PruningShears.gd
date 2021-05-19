extends KinematicBody2D
export var max_move_speed = 1100
export var min_move_speed = 700
export var stop_distance = 20

func _ready():
	# screen_size = get_viewport_rect().size
	# player will be hidden when the game starts
	hide()
	
func _process(delta):
	_look_at_mouse()
	_move_to_mouse()

func _look_at_mouse():
	look_at(get_global_mouse_position())

func _move_to_mouse():
	if position.distance_to(get_global_mouse_position()) > stop_distance:
		var direction = get_global_mouse_position() - position
		var normalized_direction = direction.normalized()
		var direction_distance = direction.length()
		move_and_slide(normalized_direction * max(min_move_speed, min(max_move_speed, direction_distance)))

func start(pos):
	position = pos
	# target = pos  # initial target is the start position
	show()
	#$CollisionShape2D.disabled = false

func snip():
	$AnimatedSprite.animation = "closed_shears"
	$SnipTimer.set_wait_time(.2)
	$SnipTimer.start()

func _on_SnipTimer_timeout():
	$AnimatedSprite.animation = "open_shears"
