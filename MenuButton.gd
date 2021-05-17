extends MenuButton

signal collect
var popup


func _ready():
	$SunlightMain.visible = false
	$SunlightMain/SunlightHUD.scale = Vector2(0,0)
	popup = get_popup()
	popup.add_item("collect money")
	popup.add_item("play minigame")
	popup.connect("id_pressed",self,"_on_item_pressed")

func _on_item_pressed(ID):
	if popup.get_item_text(ID) == "collect money":
		emit_signal("collect")

	if popup.get_item_text(ID) == "play minigame":
		get_parent().get_node("MainHUD/Counter").hide()
		get_parent().get_node("MainHUD/ShopRec").hide()
		$SunlightMain.visible = true
		$SunlightMain/SunlightHUD.scale = Vector2(1,1)
		$SunlightMain/SunlightHUD/ScoreLabel.show()
		$SunlightMain/SunlightHUD/TimeLabel.show()
		$SunlightMain/SunlightHUD/Message.show()
		$SunlightMain/SunlightHUD/StartButton.show()
		$SunlightMain/SunlightHUD/ExitButton.show()
