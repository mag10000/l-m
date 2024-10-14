extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass









func _on_exit_body_entered(body):
	if State.boss_fight_1_done == false:
		State.level_one_done = true
		State.save_menu_scene = ("res://scenes/smobeybobey_fight_1.tscn")
		get_tree().change_scene_to_file("res://scenes/smobeybobey_cutscene_1.tscn")
	else:
		State.save_menu_scene = ("res://scenes/base.tscn")
		get_tree().change_scene_to_file("res://scenes/loading_screen.tscn")
