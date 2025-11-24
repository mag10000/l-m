extends Panel


# Called when the node enters the scene tree for the first time.
func _ready():
	var user = OS.get_environment("USERNAME")
	var dir = DirAccess.open("C:\\Users\\" + user + "\\Documents\\LMdlc")
	print(dir.get_files())
	for file in dir.get_files():
		if file.contains(".zip") or file.contains(".pck"):
			if State.mod_on != file:
				$ItemList.add_item(file + " (off)",load("res://assets/File_icon.png"))
			else:
				$ItemList.add_item(file + " (on)",load("res://assets/File_icon.png"))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_item_list_item_clicked(index, at_position, mouse_button_index):
	print(index)
	var text = $ItemList.get_item_text(index)
	if text.contains("(off)"):
		var split_text = text.split(" (off)")
		print(split_text)
		text = split_text[0] + " (on)"
	if text.contains("(on)"):
		var split_text = text.split(" (on)")
		print(split_text)
		text = split_text[0] + " (off)"
	$ItemList.set_item_text(index, text)
