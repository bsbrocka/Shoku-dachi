extends KinematicBody2D

signal killed
signal update_score
export var speed:= Vector2(10.0, 10.0)
export var acceleration:=3500.0 #to make this configurable
var velocity:=Vector2.ZERO #since we're only dealing with 2d/ movement on x and y axis per second/ zero by default->will not move by default
var screen_size
export var stomp_impulse:=500.0

func _ready():
	screen_size = get_viewport_rect().size
func start(pos):
	position = pos
	show()
func _on_EnemyDetector_area_entered(area:Area2D)->void:
	velocity=calculate_stomp(velocity,stomp_impulse)
func _on_EnemyDetector_body_entered(body:PhysicsBody2D)->void:
	#queue_free() #kills player
	if body.is_in_group("enemy"):
		hide() #"kills" player
		emit_signal("killed")
	if body.is_in_group("droplet"):
		emit_signal("update_score")
		$pop.play()
	#get_tree().change_scene("res://source/screens/End Screen.tscn")
	
func _physics_process(delta: float)->void:
	var is_jump_interrupted := Input.is_action_just_released(("ui_up")) and velocity.y<0
	var direction := get_direction()
	velocity=calculate_velocity(velocity,speed,direction,is_jump_interrupted)
	velocity = move_and_slide(velocity,Vector2.UP)
	#when max score is obtained
	#if PlayerData.score==20:
		#get_tree().change_scene("res://source/screens/End Screen.tscn")
	#avoid going outside of screen
	position += velocity * delta
	position.x = clamp(position.x, 75, 425)
	position.y = clamp(position.y, 0, screen_size.y+100)
	
func get_direction()->Vector2:
	#movement to right =1, movement to left=-1, if player presses both keys the player will not move
	#jump=-1 since y-axis points down
	return Vector2(Input.get_action_strength("move_right")-Input.get_action_strength("move_left"),
	-1.0 if Input.is_action_just_pressed("ui_up") and is_on_floor() else 1.0)

func calculate_velocity(linear_velocity:Vector2, speed:Vector2,direction:Vector2,is_jump_interrupted:bool) ->Vector2:
	var new_velocity: = linear_velocity
	new_velocity.x = speed.x * direction.x
	new_velocity.y += acceleration * get_physics_process_delta_time()
	if direction.y == -1.0:
		new_velocity.y = speed.y * direction.y
	if is_jump_interrupted:
		new_velocity.y=0.0 #pressing down and up buttons will make the player jump higher
	return new_velocity

func calculate_stomp(linear_velocity:Vector2, impulse:float)->Vector2: #makes the player bounce after killing enemy
	var out:=linear_velocity
	out.y = -impulse
	return out
