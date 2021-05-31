extends Control
signal purchase
signal update_bg
signal update_plant

onready var panelsP = $TabContainer/Plants/RichTextLabel/control
onready var panelsA = $TabContainer/Accessories/RichTextLabel/control2
onready var panelsB = $TabContainer/Backgrounds/RichTextLabel/control3

#onready var priceP1 = str2var($TabContainer/Plants/RichTextLabel/control/Panel/Price/Label.text)
onready var priceP1 = str2var(panelsP.get_node("Panel1/Price/Label").text)
onready var priceP2 = str2var(panelsP.get_node("Panel2/Price/Label").text)
onready var priceP3 = str2var(panelsP.get_node("Panel3/Price/Label").text)

onready var priceA1 = str2var(panelsA.get_node("Panel1/Price/Label").text)
onready var priceA2 = str2var(panelsA.get_node("Panel2/Price/Label").text)
onready var priceA3 = str2var(panelsA.get_node("Panel3/Price/Label").text)

onready var priceB1 = str2var(panelsB.get_node("Panel1/Price/Label").text)
onready var priceB2 = str2var(panelsB.get_node("Panel2/Price/Label").text)
onready var priceB3 = str2var(panelsB.get_node("Panel3/Price/Label").text)

var buy_price = 0
var item_no = 0
var category = ""

var preview_bg = [
	"res://livespace_assets/outdoor_background.png",
	"res://livespace_assets/office_bg_2.png",
	"res://livespace_assets/office_bg.png"
]

# Called when the node enters the scene tree for the first time.
func _ready():
	self.hide()
	
	Global.load_shop()
	
	$Preview.texture = load(preview_bg[Global.shop.selected[2]])
	
	for item in range(panelsP.get_child_count()):
		if Global.shop.boughtP[item] == true:
			panelsP.get_node("Panel"+str(item+1)).get_node("buyP"+str(item+1)).text = "Select"
	for item in range(panelsA.get_child_count()):
		if Global.shop.boughtA[item] == true:
			panelsA.get_node("Panel"+str(item+1)).get_node("buyA"+str(item+1)).text = "Select"
	for item in range(panelsB.get_child_count()):
		if Global.shop.boughtB[item] == true:
			panelsB.get_node("Panel"+str(item+1)).get_node("buyB"+str(item+1)).text = "Select"
	
	panelsP.get_node("Panel"+str(Global.shop.selected[0]+1)).get_node("buyP"+str(Global.shop.selected[0]+1)).text = "Selected"
	panelsA.get_node("Panel"+str(Global.shop.selected[1]+1)).get_node("buyA"+str(Global.shop.selected[1]+1)).text = "Selected"
	panelsB.get_node("Panel"+str(Global.shop.selected[2]+1)).get_node("buyB"+str(Global.shop.selected[2]+1)).text = "Selected"
	
func _on_HomeButton_pressed():
	#get_tree().change_scene("res://Plant.tscn")
	self.hide()

func _selected(node, item):
	Global.load_shop()
	
	if category == "boughtP":
		for buttonP in range(panelsP.get_child_count()):
			if panelsP.get_node("Panel"+str(buttonP+1)).get_node("buyP"+str(buttonP+1)).text == "Selected":
				panelsP.get_node("Panel"+str(buttonP+1)).get_node("buyP"+str(buttonP+1)).text = "Select"
		Global.shop.selected[0] = item
		emit_signal("update_plant")
	
	elif category == "boughtA":
		for buttonA in range(panelsA.get_child_count()):
			if panelsA.get_node("Panel"+str(buttonA+1)).get_node("buyA"+str(buttonA+1)).text == "Selected":
				panelsA.get_node("Panel"+str(buttonA+1)).get_node("buyA"+str(buttonA+1)).text = "Select"
		Global.shop.selected[1] = item
		
	else:
		for buttonB in range(panelsB.get_child_count()):
			if panelsB.get_node("Panel"+str(buttonB+1)).get_node("buyB"+str(buttonB+1)).text == "Selected":
				panelsB.get_node("Panel"+str(buttonB+1)).get_node("buyB"+str(buttonB+1)).text = "Select"
		Global.shop.selected[2] = item
		emit_signal("update_bg")
		
	node.text = "Selected"
	print(Global.shop)
	Global.save_shop()

func _change_plant():
	$ConfirmPlant.hide()
	_selected(panelsP.get_node("Panel"+str(item_no+1)).get_node("buyP"+str(item_no+1)), item_no)

func _no_plant():
	$ConfirmPlant.hide()
	
func _change_bg():
	$Preview.hide()
	$ConfirmBg.hide()
	_selected(panelsB.get_node("Panel"+str(item_no+1)).get_node("buyB"+str(item_no+1)), item_no)

func _no_bg():
	$Preview.hide()
	$ConfirmBg.hide()

func _button_status():
	if category == "boughtP" and Global.shop.boughtP[item_no] == false:
		$BuyMessage.show()
	elif category == "boughtA" and Global.shop.boughtA[item_no] == false:
		$BuyMessage.show()
	elif category == "boughtB" and Global.shop.boughtB[item_no] == false:
		$BuyMessage.show()
	else:
		if category == "boughtP" and panelsP.get_node("Panel"+str(item_no+1)).get_node("buyP"+str(item_no+1)).text != "Selected":
			$ConfirmPlant.show()
		elif category == "boughtA" and panelsA.get_node("Panel"+str(item_no+1)).get_node("buyA"+str(item_no+1)).text != "Selected":
			_selected(panelsA.get_node("Panel"+str(item_no+1)).get_node("buyA"+str(item_no+1)), item_no)
		else:
			if panelsB.get_node("Panel"+str(item_no+1)).get_node("buyB"+str(item_no+1)).text != "Selected":
				$Preview.texture = load(preview_bg[item_no])
				$Preview.show()
				$ConfirmBg.show()

func _on_buyP1_pressed():
	buy_price = priceP1
	item_no = 0
	category = "boughtP"
	_button_status()

func _on_buyP2_pressed():
	buy_price = priceP2
	item_no = 1
	category = "boughtP"
	_button_status()
	
func _on_buyP3_pressed():
	buy_price = priceP3
	item_no = 2
	category = "boughtP"
	_button_status()

func _on_buyA1_pressed():
	buy_price = priceA1
	item_no = 0
	category = "boughtA"
	_button_status()

func _on_buyA2_pressed():
	buy_price = priceA2
	item_no = 1
	category = "boughtA"
	_button_status()
	
func _on_buyA3_pressed():
	buy_price = priceA3
	item_no = 2
	category = "boughtA"
	_button_status()

func _on_buyB1_pressed():
	buy_price = priceB1
	item_no = 0
	category = "boughtB"
	_button_status()

func _on_buyB2_pressed():
	buy_price = priceB2
	item_no = 1
	category = "boughtB"
	_button_status()

func _on_buyB3_pressed():
	buy_price = priceB3
	item_no = 2
	category = "boughtB"
	_button_status()

func _on_YesButton_pressed():
	$BuyMessage.hide()
	
	Global.load_shop()
	
	if buy_price > Global.currency:
		$NoFunds.show()
	else:
		Global.currency -= buy_price
		emit_signal("purchase")
		
		if category == "boughtP":
			Global.shop.boughtP[item_no] = true
			panelsP.get_node("Panel"+str(item_no+1)).get_node("buyP"+str(item_no+1)).text = "Select"
		elif category == "boughtA":
			Global.shop.boughtA[item_no] = true
			panelsA.get_node("Panel"+str(item_no+1)).get_node("buyA"+str(item_no+1)).text = "Select"
		else:
			Global.shop.boughtB[item_no] = true
			panelsB.get_node("Panel"+str(item_no+1)).get_node("buyB"+str(item_no+1)).text = "Select"
		
		print(Global.shop)
		Global.save_shop()

func _on_NoButton_pressed():
	buy_price = 0
	item_no = 0
	category = ""
	$BuyMessage.hide()

func _on_OkButton_pressed():
	buy_price = 0
	item_no = 0
	category = ""
	$NoFunds.hide()

