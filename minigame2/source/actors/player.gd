extends Actor

export var stomp_impulse:=1000.0
func _on_EnemyDetector_area_entered(area:Area2D)->void:
	velocity=calculate_stomp(velocity,stomp_impulse)
	
func _on_EnemyDetector_body_entered(body:PhysicsBody2D)->void:
	queue_free() #kills player
	get_tree().change_scene("res://source/screens/End Screen.tscn")
	
func _physics_process(delta: float)->void:
	var is_jump_interrupted := Input.is_action_just_released(("ui_up")) and velocity.y<0
	var direction := get_direction()
	velocity=calculate_velocity(velocity,speed,direction,is_jump_interrupted)
	velocity = move_and_slide(velocity,Vector2.UP)
	#when max score is obtained
	if PlayerData.score==20:
		get_tree().change_scene("res://source/screens/End Screen.tscn")
	
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
	

