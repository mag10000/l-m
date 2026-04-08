extends Panel

@export var URL : String = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS_XJPZaWfGfx3rso1POXsawWUc0L_1XozN3Q&s"
@export var data : Dictionary

var body = ""
var title = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	URL = data["img_url"]
	$title.text = data["title"]
	$preview.text = data["preview"] + "..."
	body = data["body"]
	title = data["title"]
	$"Image Web".size = Vector2(75.0,75.0)
	$"Image Web".url = URL
	$"Image Web".download_image()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$"Image Web".size = Vector2(75.0,75.0)


func _on_button_pressed():
	NewsGlobal.body = body
	NewsGlobal.title = title
	get_tree().change_scene_to_file("res://news_viewer.tscn")
