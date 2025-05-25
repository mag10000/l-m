extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	if State.mobile == true:
		$Control/CanvasLayer.visible = true
	if State.mobile == false:
		$Control/CanvasLayer.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$AudioStreamPlayer2D.volume_db = State.sound



func _on_area_2d_body_entered(body):
	if State.strange_signal_level_done == false:
		State.save_menu_scene = ("res://scenes/strange_signal_cutscene_2.tscn")
		State.strange_signal_level_done = true
		get_tree().change_scene_to_file("res://scenes/strange_signal_cutscene_2.tscn")
	else:
		State.save_menu_scene = ("res://scenes/base.tscn")
		get_tree().change_scene_to_file("res://scenes/loading_screen.tscn")
func _on_button_pressed():
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
