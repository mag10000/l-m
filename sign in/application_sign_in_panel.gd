extends Panel

@onready var panel = $"."

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_application_sign_in_pressed():
	panel.show()
	if State.app_sign_ins != {}:
		for app in State.app_sign_ins:
			var button = Button.new()
			button.text = str(app)
			button.add_theme_font_override("font",load("res://assets/fonts/PressStart2P-Regular.ttf"))
			button.add_theme_font_size_override("font_size",24)
			$ScrollContainer/VBoxContainer.add_child(button)
	


func _on_add_app_pressed():
	State.app_sign_ins[$HBoxContainer/name.text] = $HBoxContainer/path.text
	var button = Button.new()
	button.text = str($HBoxContainer/name.text)
	button.add_theme_font_override("font",load("res://assets/fonts/PressStart2P-Regular.ttf"))
	button.add_theme_font_size_override("font_size",24)
	$ScrollContainer/VBoxContainer.add_child(button)


func _on_close_pressed():
	$".".hide()
	for child in $ScrollContainer/VBoxContainer.get_children():
		child.queue_free()


func _on_button_pressed():
	if State.app_sign_ins.has($HBoxContainer2/LineEdit.text):
		OS.shell_open(State.app_sign_ins[$HBoxContainer2/LineEdit.text])
		$HBoxContainer2.hide()
		$ScrollContainer.hide()
		$HBoxContainer.hide()
		$close.hide()
		$Header.text = "Waiting..."
		save_manager.path = "user://app_provided_data.json"
		save_manager.write_save({
			"new_user" : State.fist_time_played,
			"version" : State.version,
			"mobile" : State.mobile
		})
		$Timer.start()
		if FileAccess.file_exists("user://auth_session.dat"):
			var save_game_path = "user://auth_session.dat"
			DirAccess.remove_absolute(save_game_path)


func _on_timer_timeout():
	if FileAccess.file_exists("user://app_sign_in_data.json"):
		print("file exists")
		sign_in()
	else:
		print("HUH?????")

func sign_in():
	$Header.text = "Signed In"
	save_manager.path = "user://app_sign_in_data.json"
	var data = save_manager.read_save()
	save_manager.path = "user://lm_data.json"
	var save_game_path = "user://app_sign_in_data.json"
	DirAccess.remove_absolute(save_game_path)
	hide()
	$"..".panel_app_display(data)
	if data["auto_login"] == true:
		save_manager.path = "user://auto_sign_in_app.dat"
		save_manager.write_save({
			"data" : data,
		})
	$"..".app_signed_in = true
	save_manager.path = "user://lm_data.json"
