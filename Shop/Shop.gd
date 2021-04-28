extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	self.hide()
	$BuyMessage.hide()

func _on_HomeButton_pressed():
	self.hide()

func _on_Purchase_pressed():
	$BuyMessage.show()

func _on_NoButton_pressed():
	$BuyMessage.hide()
