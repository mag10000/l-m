extends Node2D

var date_dict = Time.get_date_dict_from_system()  

var current_month = date_dict["month"]


# Called when the node enters the scene tree for the first time.
func _ready():
	if State.mobile == true:
		$Control/CanvasLayer.visible = true
	if State.mobile == false:
		$Control/CanvasLayer.visible = false
		
	if State.show_leaderboard_timer == true:
		State.instanciate_LeaderboardTimer()
		State.score_level = "Tutorial"
	else:
		State.kill_LeaderboardTimer()
		State.score_level = "Tutorial"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if current_month == 12:
		$GPUParticles2D.emitting = true
		$TileMap2.visible = true
	var current_day = date_dict["day"]
	if current_month == 10 && current_day == 31:
		$ColorRect.visible = true

func _on_button_pressed():
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
