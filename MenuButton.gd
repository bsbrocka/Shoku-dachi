extends MenuButton

var popup

func _ready():
	$Main.visible = false
	$Main/HUD.scale = Vector2(0,0)
	popup = get_popup()
	popup.add_item("collect money")
	popup.add_item("play minigame")
	popup.connect("id_pressed",self,"_on_item_pressed")

func _on_item_pressed(ID):
	if popup.get_item_text(ID) == "play minigame":
		$Main.visible = true
		$Main/HUD.scale = Vector2(1,1)
		$Main/HUD/StartButton.show()
		$Main/HUD/ExitButton.show()
