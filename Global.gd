extends Node

var currency = 0
var last_collect = 0

var shop = {
	'boughtP' : [true, false, false],
	'boughtA' : [true, false, false, false, false, false],
	'boughtB' : [true, false, false, false],
	'selected' : [0,0,0]
	}

var currency_path = 'user://currency'
var shop_path = 'user://shop'
var time_path = 'user://time'

func save_currency():
	var file = File.new()
	file.open(currency_path, file.WRITE_READ)
	file.store_var(currency)
	file.close()

func load_currency():
	var file = File.new()
	if not file.file_exists(currency_path):
		return false
	file.open(currency_path, file.READ)
	currency = file.get_var()
	file.close()
	return true

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
	
func save_time():
	var file = File.new()
	file.open(time_path, file.WRITE_READ)
	file.store_var(last_collect)
	file.close()

func load_time():
	var file = File.new()
	if not file.file_exists(time_path):
		return false
	file.open(time_path, file.READ)
	last_collect = file.get_var()
	file.close()
	return true
