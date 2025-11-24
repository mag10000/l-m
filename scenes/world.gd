extends Node2D

var drone = false

var date_dict = Time.get_date_dict_from_system()  

var current_month = date_dict["month"]

# Called when the node enters the scene tree for the first time.
func _ready():
	if State.mobile == true:
		$Control/CanvasLayer.visible = true
	if State.mobile == false:
		$Control/CanvasLayer.visible = false
	State.fist_time_played = false
	
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
		$winter_map.visible = true
	var current_day = date_dict["day"]
	if current_month == 10 && current_day == 31:
		$ColorRect.visible = true
	if drone == true:
		$"main dude/Camera2D".position.y += 1
		Engine.time_scale = 0


func _unhandled_input(event):
	if Input.is_action_just_pressed("drone"):
		print("what!")
		drone = !drone


func _on_right_button_down():
	$"main dude".velocity.x += 1


func _on_button_pressed():
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
