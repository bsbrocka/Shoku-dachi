#data here are accessible by other scripts/used as autoload

extends Node

signal score_update
signal time_update

var score := 0 setget set_score
var remaining_time:=20 setget set_time

func set_score(value: int)->void:
	score = value
	emit_signal("score_update")
	
func set_time(value: int)->void:
	remaining_time-=1
	emit_signal("time_update")
	
func reset()->void:
	score=0
	remaining_time=20

