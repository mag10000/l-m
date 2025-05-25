extends Node2D

var play = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	State.play = play
	
	if play == false:
		$"main dude".position.y = -68
		$Control/CanvasLayer/Button.text = "Play"
	if play == true:
		$Control/CanvasLayer/Button.text = "Make"


func _on_button_pressed():
	if play == false:
		$"main dude".position = Vector2(40, -68)
	play = !play


func _on_grass_pressed():
	State.Level_editor_block = "grass"


func _on_dirt_pressed():
	State.Level_editor_block = "dirt"


func _on_stone_pressed():
	State.Level_editor_block = "stone"


func _on_air_pressed():
	State.Level_editor_block = "air"
