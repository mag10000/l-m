extends Node

var json = JSON.new()
var path = "user://lm_data.json"

var data = {}


func write_save(content):
	var file = FileAccess.open(path, FileAccess.WRITE)
	file.store_string(json.stringify(content))
	file.close()
	file = null

func read_save():
	if FileAccess.file_exists(path):
		var file = FileAccess.open(path, FileAccess.READ)
		var new_json = JSON.new()
		var content = new_json.parse(file.get_as_text())
		return new_json.get_data()
	else:
		OS.alert("you don't have a save!")
		pass

func create_new_save_file():
	var file = FileAccess.open("res://scripts/default_save.json", FileAccess.READ)
	var content = json.parse_string(file.get_as_text())
	data = content
	write_save(content)

# Called when the node enters the scene tree for the first time.
func _ready():
	# If there is a save file that exists
	if FileAccess.file_exists("user://lm_data.json"):
		# load data
		pass
	# Otherwise 
	else:
		# create a new save file
		# create_new_save_file()
		pass
