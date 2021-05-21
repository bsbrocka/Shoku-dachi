extends Node

var currency = 0
var shop = {
	'boughtP' : [true, false, false],
	'boughtA' : [true, false, false],
	'boughtB' : [true, false, false],
	'selected' : [0,0,0]
	}

var currency_path = 'user://currency'
var shop_path = 'user://shop'

func save_shop():
	var file = File.new()
	file.open(shop_path, file.WRITE_READ)
	file.store_var(shop)
	file.close()

func load_shop():
	var file = File.new()
	if not file.file_exists(shop_path):
		return false
	file.open(shop_path, file.READ)
	shop = file.get_var()
	file.close()
	return true
