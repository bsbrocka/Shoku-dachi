extends Area2D

onready var anim_player: AnimationPlayer = get_node("AnimationPlayer")
export var score:= 1
onready var playerNode =  get_node("/root/PlayerData")
func _on_droplet_body_entered(body):
	anim_player.play("fade_out")
	playerNode.score+=score
