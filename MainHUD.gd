extends CanvasLayer

func _on_ShopButton_pressed():
	get_parent().get_node("MainScreenMusic").mainloop = false
	get_parent().get_node("MainScreenMusic").stop()
	$ShopRec.hide()
	get_parent().get_node("Shop").show()
	get_parent().get_node("Shop/HomeButton").show()
	get_parent().get_node("ShopMusic").shoploop = true
	get_parent().get_node("ShopMusic").play()
	
func _on_SunlightMain_hide():
	$ShopRec.show()
	$Counter.show()
	get_parent().get_node("MainScreenMusic").mainloop = true
	get_parent().get_node("MainScreenMusic").play()

func _on_Shop_hide():
	get_parent().get_node("ShopMusic").shoploop = false
	get_parent().get_node("ShopMusic").stop()
	$ShopRec.show()
	get_parent().get_node("MainScreenMusic").mainloop = true
	get_parent().get_node("MainScreenMusic").play()

func _on_PruningMain_hide():
	$ShopRec.show()
	$Counter.show()
	get_parent().get_node("Bar").show()
	get_parent().get_node("MenuButton").mouse_filter = 0
	get_parent().get_node("MainScreenMusic").mainloop = true
	get_parent().get_node("MainScreenMusic").play()

func _on_WateringMain_hide():
	$ShopRec.show()
	$Counter.show()
	get_parent().get_node("MainScreenMusic").mainloop = true
	get_parent().get_node("MainScreenMusic").play()
	
