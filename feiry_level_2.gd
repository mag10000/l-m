extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	if State.mobile == true:
		$Control/CanvasLayer.visible = true
	if State.mobile == false:
		$Control/CanvasLayer.visible = false
	
	if State.show_leaderboard_timer == true:
		State.instanciate_LeaderboardTimer()
		State.score_level = "Dragon level 2"
	else:
		State.kill_LeaderboardTimer()
		State.score_level = "Dragon Level 2"



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	if State.fire_2 == false:
		State.save_menu_scene = ("res://scenes/cutscene_5.tscn")
		State.fire_2 = true
		get_tree().change_scene_to_file("res://scenes/cutscene_5.tscn")
	else:
		State.save_menu_scene = ("res://scenes/base.tscn")
		get_tree().change_scene_to_file("res://scenes/loading_screen.tscn")
