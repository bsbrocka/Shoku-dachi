extends Control

onready var scene_tree:= get_tree()
onready var score: Label = get_node("score")
onready var timer: Label =get_node("timer")

func _ready() ->void:
	PlayerData.connect("score_update",self,"update_interface")
	PlayerData.connect("time_update",self,"update_interface")
	update_interface()
	
func update_interface() ->void:
	score.text="Score:%s" % PlayerData.score
	timer.text="Time Left:%s" %PlayerData.remaining_time
