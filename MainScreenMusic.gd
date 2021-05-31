extends AudioStreamPlayer
export (bool) var mainloop = true

func _ready():
	connect("finished", self, "_on_finished")

func _on_finished():
	if mainloop == true:
		play()
