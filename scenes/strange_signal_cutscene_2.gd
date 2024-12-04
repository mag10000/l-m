extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	State.fist_time_played = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if State.player_3_in == true:
		$ian.visible = true


func _on_timer_timeout():
	State.save_menu_scene = ("res://scenes/base.tscn")
	get_tree().change_scene_to_file("res://scenes/loading_screen.tscn")
