extends Panel

var title : String = ""
var discription : String = ""
var img_path = load("res://lm_shop_coin.png")


# Called when the node enters the scene tree for the first time.
func _ready():
	$VBoxContainer/Title.text = title
	$VBoxContainer/Img.texture = img_path
	$VBoxContainer/body.text = discription


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
