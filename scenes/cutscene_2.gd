extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	State.jacob_level_1_done = true
	State.save_menu_scene = ("res://scenes/cutscene_3.tscn")
	get_tree().change_scene_to_file("res://scenes/cutscene_3.tscn")
