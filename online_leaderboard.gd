extends Control

var open_sign_in = false

var format = "metadata"

var doing = true

var started_gridding_ishthing = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$Loading.hide()
	if doing == false:
		if State.user_info["signed_in"] == true:
			$Main.hide()
			open_sign_in = false
			State.player_name = State.user_info["username"]
		else:
			$Main.show()
			open_sign_in = true
		$Submit/score.text = "time: " + _format_time(State.score)
		
		if State.score == 0:
			$Submit/Button.disabled = true
	else:
		doing == true
	
	$Submit/score.text = _format_time(State.score)
	
	var division = 17 % 8
	print(division)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if open_sign_in == true && State.user_info["signed_in"] == true:
		open_sign_in = false
		State.player_name = State.user_info["username"]
		$Main.hide()
	if doing == false:
		doing = true
		$Leaderboard/ScrollContainer/GridContainer._leaderboard_start()
		if State.score == 0:
			$Submit/Button.disabled = true
		else:
			print("score not zero")
	$Main/Button2.visible = $Main/SignedInPanel.visible


func _on_button_pressed():
	if format == "metadata":
		if State.player_name.contains(","):
			var new_to_set = State.player_name.split(",")
			State.player_name = new_to_set[0]
		State.player_name += "(v3.5.4)"
	else:
		State.player_name = State.player_name + "," + State.score_level
		print("Name Format")
	
	print(format)
	
	var sw_result : Dictionary = await SilentWolf.Scores.save_score(State.player_name, State.score, "main",{"level" : State.score_level,"effect" : $Submit/ColorPickerButton.color}).sw_save_score_complete
	print("score persisted succsesfully:" + str(sw_result.score_id))
	$Leaderboard/ScrollContainer/GridContainer._leaderboard_start()
	$Submit/Button.disabled = true

func _format_time(time):
	var text = ""
	var seconds = int(time) % 60
	var minutes = int(time) / 60
	var millaseconds = time - int(time)
	var millaseconds_round = _round(millaseconds,2)
	var millaseconds_format_1 = str(millaseconds_round * 10)
	var millaseconds_format_2 = millaseconds_format_1.split(".")
	var millaseconds_final = millaseconds_format_2[0] + millaseconds_format_2[1]
	var formatted = (str(minutes) + ":" + str(int(seconds)) + ":" + str(millaseconds_final))
	return formatted
func _round(num,places):
	return (round(num*pow(10,places))/pow(10,places))


func _on_back_pressed():
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")


func _on_button_2_pressed():
	open_sign_in = false
	State.player_name = State.user_info["username"]
	$Main.hide()
	$Leaderboard/ScrollContainer/GridContainer._leaderboard_start()


func _on_button_3_pressed():
	$Submit/Label.text = "[wave]See Times"
	$Submit/score.hide()
	$Submit/Button.hide()
	$Main.hide()
	$Leaderboard/ScrollContainer/GridContainer._leaderboard_start()


func _on_formatbutton_pressed():
	if format == "metadata":
		format = "name"
		$Submit/formatbutton.text = 'Submiting name format'
		return
	if format == "name":
		format = "metadata"
		$Submit/formatbutton.text = 'Submiting metadata format'
		return
