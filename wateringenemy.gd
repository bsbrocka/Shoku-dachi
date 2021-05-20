extends KinematicBody2D

export var speed:= Vector2(200.0, 800.0)
export var acceleration:=3000.0 #to make this configurable
var velocity:=Vector2.ZERO #since we're only dealing with 2d/ movement on x and y axis per second/ zero by default->will not move by default

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


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
