extends Node2D

func _ready() ->void:
	$Timer.start()
	
func _on_Timer_timeout():
	PlayerData.remaining_time-=1
	if PlayerData.remaining_time<=0:
		get_tree().change_scene("res://source/screens/End Screen.tscn") #time's up
