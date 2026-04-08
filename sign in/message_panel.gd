extends Panel


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$header.text = "Message from " + $"..".app_name
	if FileAccess.file_exists("user://app_message.json"):
		save_manager.path = "user://app_message.json"
		var dict = save_manager.read_save()
		save_manager.path = "user://lm_data.json"
		var save_game_path = "user://app_message.json"
		DirAccess.remove_absolute(save_game_path)
		show_msg(dict)

func show_msg(dictionary: Dictionary):
	$msg.text = dictionary["msg"]
	show()
	await get_tree().create_timer(5.0).timeout
	hide()


func _on_msg_meta_clicked(meta):
	OS.shell_open(str(meta))
