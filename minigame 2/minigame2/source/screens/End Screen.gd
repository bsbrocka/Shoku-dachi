extends Control

onready var label:Label = get_node("score")

func _ready():
	label.text=label.text %[PlayerData.score]
