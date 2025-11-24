extends Node2D

var date_dict = Time.get_date_dict_from_system()  

var current_month = date_dict["month"]


# Called when the node enters the scene tree for the first time.
func _ready():
	if State.mobile == true:
		$Control/CanvasLayer.visible = true
	if State.mobile == false:
		$Control/CanvasLayer.visible = false
	State.co_op_unlocked = false
	State.player_2_in = false
	State.player_4_in = false
	State.player_4_in = false
	State.on_a_jacoblevel = true
	
	if State.show_leaderboard_timer == true:
		State.instanciate_LeaderboardTimer()
		State.score_level = "dragon Level 1"
	else:
		State.kill_LeaderboardTimer()
		State.score_level = "dragon Level 1"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if current_month == 12:
		$GPUParticles2D.emitting = false
		$TileMap2.visible = false
	var current_day = date_dict["day"]
	if current_month == 10 && current_day == 31:
		$ColorRect.visible = true


func _on_area_2d_body_entered(body):
	if State.jacob_level_1_done == false:
		State.save_menu_scene = ("res://scenes/cutscene_2.tscn")
		State.co_op_unlocked = true
		State.on_a_jacoblevel = false
		get_tree().change_scene_to_file("res://scenes/cutscene_2.tscn")
	else:
		State.save_menu_scene = ("res://scenes/base.tscn")
		State.co_op_unlocked = true
		State.on_a_jacoblevel = false
		get_tree().change_scene_to_file("res://scenes/loading_screen.tscn")
		
