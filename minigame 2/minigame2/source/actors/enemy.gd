extends "res://source/actors/actor.gd"

func _ready()->void:
	set_physics_process(false)
	velocity.x=-speed.x
	
func _on_StompDetection_body_entered(body:PhysicsBody2D)->void: #killing the enemy
	if body.global_position.y > get_node("StompDetection").global_position.y:
		return
	get_node("CollisionShape2D").disabled=true
	queue_free() #deletes the enemy
	
func _physics_process(delta:float)->void:
	velocity.y+=acceleration*delta
	if is_on_wall():
		velocity*=-1.0 #change directions when it hits a wall
	velocity.y=move_and_slide(velocity,Vector2.UP).y



