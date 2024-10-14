extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	if State.jacob_level_1_done == false:
		State.save_menu_scene = ("res://scenes/cutscene_2.tscn")
		get_tree().change_scene_to_file("res://scenes/cutscene_2.tscn")
	else:
		State.save_menu_scene = ("res://scenes/base.tscn")
		get_tree().change_scene_to_file("res://scenes/loading_screen.tscn")
