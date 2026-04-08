extends ColorRect

var url = "https://www.youtubekids.com/watch?v=ZTwiVjC9GwM"
var Display = ""

var gview = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Label.text = Display


func _on_button_pressed():
	var view = WebView.new()
	view.url = url
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
