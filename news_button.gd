extends Button

var action = ""
var action_data = ""

var gview

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_pressed():
	print("Action:", action)
	print("Data:", action_data)
	if action == "shell_open":
		OS.shell_open(action_data)
	if action == "write_data":
		NewsGlobal.data[NewsGlobal.size()] = action_data
	if action == "open_steam":
		OS.shell_open("steam://rungameid/" + action_data)
	if action == "make_email":
		OS.shell_open("https://mail.google.com/mail/u/0/?fs=1&tf=cm&source=mailto&su=" + action_data + "&to=lm.superheroes.official@gmail.com")
	if action == "change_scene":
		get_tree().change_scene_to_file(action_data)
	if action == "webview":
		var view = WebView.new()
		view.url = action_data
		view.capture_keys = true
		view.auto_load = true
		var texture = TextureRect.new()
		view.add_child(texture)
		var button = Button.new()
		button.text = "Close"
		button.add_theme_font_override("font",load("res://assets/fonts/PressStart2P-Regular.ttf"))
		button.add_theme_font_size_override("font",64)
		button.pressed.connect(_close)
		gview = view
		view.add_child(button)
		add_child(view)

func _close():
	print("HI")
	if gview:
		gview.queue_free()
