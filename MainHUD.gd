extends CanvasLayer

func _on_ShopButton_pressed():
	$ShopRec.hide()
	get_parent().get_node("Shop").show()
	get_parent().get_node("Shop/HomeButton").show()

func _on_SunlightMain_hide():
	$ShopRec.show()
	$Counter.show()

func _on_Shop_hide():
	$ShopRec.show()
