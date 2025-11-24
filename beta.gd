extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		_on_button_pressed()

func _on_button_pressed():
	if $LineEdit.text == "stamp act":
		State.beta_test = true
		hide()
		$"../AcceptDialog".popup()
