extends Area2D
signal hit

export var speed = 400   # how fast the player will move (pixels per sec)
var screen_size  # size of game window
var target = Vector2()  # variable to hold clicked position (for touch devices)

func _ready():
	screen_size = get_viewport_rect().size
	# player will be hidden when the game starts
	hide()

# change the target whenever a touch event happens
func _input(event):
	if event is InputEventScreenTouch and event.pressed:
		target = event.position

func _process(delta):
	var velocity = Vector2()  # the player's movement vector
	
	# move towards the target and stop when close
	if position.distance_to(target) > 10:
		velocity = target - position
	
	# keyboard controls (for desktop use)
	# ui_direction's default uses arrow keys
	# mapping can be changed in <input map> under project settings
	# (0,0) refers to the top left corner !
	# if Input.is_action_pressed("ui_right"):
	# 	velocity.x += 1
	# if Input.is_action_pressed("ui_left"):
	# 	velocity.x -= 1
	# if Input.is_action_pressed("ui_down"):
	# 	velocity.y += 1
	# if Input.is_action_pressed("ui_up"):
	#	velocity.y -= 1
	
	# normalizing speed prevents case where diagonal movement is faster
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()
	
	# clamp prevents the player from leaving the screen
	# delta is frame length; ensures consistent movement despite changes 
	# in frame rate
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	
	# checks which animation to use based on movement
	if velocity.x != 0:
		# $AnimatedSprite.animation = "walk"
		$AnimatedSprite.flip_v = false
		# assigns true if velocity.x < 0, false otherwise
		$AnimatedSprite.flip_h = velocity.x < 0
	if velocity.y != 0:
		$AnimatedSprite.animation = "up"
		$AnimatedSprite.flip_v = velocity.y > 0

# collision detection
func _on_Player_body_entered(_body):
	hide()  # player disappears after being hit
	emit_signal("hit")
	# disables shape when it's safe to prevent errors 
	# i.e. disabling during collision processing
	$CollisionShape2D.set_deferred("disabled",true)

func start(pos):
	position = pos
	target = pos  # initial target is the start position
	show()
	$CollisionShape2D.disabled = false
	
	
	
	
	
