extends CanvasLayer

var move_id = "anucool"

func _ready():
	name = "toast_" + move_id
	$"move toast/ColorRect/HBoxContainer/HBoxContainer/title".text = State.move_set[move_id].name
	$"move toast/ColorRect/HBoxContainer/HBoxContainer/discription".text = State.move_set[move_id].discription
	$"move toast/ColorRect/HBoxContainer/TextureRect".texture = State.move_set[move_id].icon
