extends AudioStreamPlayer
export (bool) var shoploop = false

func _ready():
	connect("finished", self, "_on_finished")

func _on_finished():
	if shoploop == true:
		play()
