extends MenuButton

signal collect
var popup


func _ready():
	$SunlightMain.visible = false
	$SunlightMain/SunlightHUD.scale = Vector2(0,0)
	$PruningMain.visible = false
	$PruningMain/PruningHUD.scale = Vector2(0,0)
	popup = get_popup()
	popup.add_item("collect money")
	popup.add_item("play sunlight minigame")
	popup.add_item("play pruning minigame")
	popup.connect("id_pressed",self,"_on_item_pressed")

func _on_item_pressed(ID):
	if popup.get_item_text(ID) == "collect money":
		emit_signal("collect")

	if popup.get_item_text(ID) == "play sunlight minigame":
		get_parent().get_node("MainHUD/Counter").hide()
		get_parent().get_node("MainHUD/ShopRec").hide()
		$SunlightMain.visible = true
		$SunlightMain/SunlightHUD.scale = Vector2(1,1)
		$SunlightMain/SunlightHUD/ScoreLabel.show()
		$SunlightMain/SunlightHUD/TimeLabel.show()
		$SunlightMain/SunlightHUD/Message.show()
		$SunlightMain/SunlightHUD/StartButton.show()
		$SunlightMain/SunlightHUD/ExitButton.show()

	if popup.get_item_text(ID) == "play pruning minigame":
		get_parent().get_node("MainHUD/Counter").hide()
		get_parent().get_node("MainHUD/ShopRec").hide()
		$PruningMain.visible = true
		$PruningMain/PruningHUD.scale = Vector2(1,1)
		$PruningMain/PruningHUD/ScoreLabel.show()
		$PruningMain/PruningHUD/TimeLabel.show()
		$PruningMain/PruningHUD/Message.show()
		$PruningMain/PruningHUD/StartButton.show()
		$PruningMain/PruningHUD/ExitButton.show()
		
