extends RigidBody2D
export var speed:= Vector2(300.0, 1000.0)
export var acceleration:=4000.0 #to make this configurable
var velocity:=Vector2.ZERO 

func _ready():
	set_physics_process(false)

func _physics_process(delta:float)->void:
	velocity.y+=acceleration*delta

func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		queue_free()

func _on_droplet_body_entered(body):
	if body is TileMap:
		queue_free()
