extends CanvasLayer

onready var scene_tree:= get_tree()
onready var score: Label = get_node("score")
onready var timer: Label =get_node("timer")

#func _ready() ->void:
#	$wateringmain.connect("score_update",self,"update_interface")
#	$wateringmain.connect("time_update",self,"update_interface")
#	update_interface()
	
#func update_interface(score,remaining_time) ->void:
#	score.text="Score: " + str(score) 
#	timer.text="Time Left: " + str(remaining_time20..)

func update_time(time):
	timer.text = "Time Left:%s" %time
func update_score(pts):
	score.text = "Score:%s" %pts
