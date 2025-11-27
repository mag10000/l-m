extends GridContainer

var ignore = false

var player_list_with_pos = []

var doing = false

func _ready() -> void:
	#_leaderboard_start()
	pass

#	$RichTextLabel.add_theme_font_override("normal_font",load("res://assets/fonts/PressStart2P-Regular.ttf"))
#	$RichTextLabel.add_theme_font_size_override("normal_font_size",8)


func _leaderboard_start():
	print("leaderboard started")
	$"../../../Loading".show()
	if $"../../..".started_gridding_ishthing == false:
		$"../../..".started_gridding_ishthing = true
		ignore = true
		
	if State.score == 0 or $"../../../Submit/score".text == "0:0:00":
		$"../../../Submit/Button".disabled = true

	var children = get_children()
	if children != []:
		for child in children:
			child.queue_free()
	var sw_result: Dictionary = await SilentWolf.Scores.get_scores(0).sw_get_scores_complete
	player_list_with_pos = sort_players_and_add_position(SilentWolf.Scores.scores)
	add_player_to_grid(player_list_with_pos)


func add_player_to_grid(player_list):
	var pos_vbox = VBoxContainer.new()
	var name_vbox = VBoxContainer.new()
	var metadata_vbox = VBoxContainer.new()
	var score_vbox = VBoxContainer.new()
	
	
	var non_reverse_player_list_with_pos = player_list_with_pos
	player_list_with_pos.reverse()
	
	var convert = false
	var convert_to : Dictionary
	
	#print(player_list_with_pos)
	
	for score_data in non_reverse_player_list_with_pos:
		var pos_label = Label.new()
		pos_label.text = str(score_data["position"])
		pos_label.add_theme_font_override("font",load("res://assets/fonts/PressStart2P-Regular.ttf"))
		pos_label.add_theme_font_size_override("font_size",8)
		pos_label.show()
		if $"../../..".started_gridding_ishthing == false or ignore == true:
			pos_vbox.add_child(pos_label)
	if $"../../..".started_gridding_ishthing == false or ignore == true:
		add_child(pos_vbox)
	
	var new_pos_vobox_data = pos_vbox.get_children()
	new_pos_vobox_data.reverse()
	
	for child in pos_vbox.get_children():
		child.queue_free()
	
	var numb = 1
	for label in new_pos_vobox_data:
		var pos_label = Label.new()
		pos_label.text = str(numb)
		numb += 1
		pos_label.add_theme_font_override("font",load("res://assets/fonts/PressStart2P-Regular.ttf"))
		pos_label.add_theme_font_size_override("font_size",8)
		pos_label.show()
		if $"../../..".started_gridding_ishthing == false or ignore == true:
			pos_vbox.add_child(pos_label)
	
	for score_data in player_list_with_pos:
		var name_label = Label.new()
		var new_player_name
		if score_data["player_name"].contains(","):
			var splitted = score_data["player_name"].split(",")
			convert_to[score_data["player_name"]] = splitted[1]
			#print("pre:" + str(convert_to))
			convert = true
			name_label.text = "," + splitted[0]
		else:
			name_label.text = "," + str(score_data["player_name"])
		if score_data.has("metadata"):
			if score_data["metadata"].has("effect"):
				var metadata = score_data["metadata"]
				if metadata["effect"].contains("color:"):
					var color = metadata["effect"].split(":")[1]
					name_label.add_theme_color_override("font_color",Color(color))
		if name_label.text.contains("(v3.5.4)"):
			print("okay well WHATTTTTTTT :(:(:(:(:(:(:(:(:(:(:(:(:(:(:(")
			name_label.text = name_label.text.split("(v3.5.4)")[0]
		else:
			print("okay well this might be fine idk...")
		name_label.add_theme_font_override("font",load("res://assets/fonts/PressStart2P-Regular.ttf"))
		name_label.add_theme_font_size_override("font_size",8)
		name_label.show()
			
		if $"../../..".started_gridding_ishthing == false or ignore == true:
			name_vbox.add_child(name_label)
	if $"../../..".started_gridding_ishthing == false or ignore == true:
		add_child(name_vbox)
	
	for score_data in player_list_with_pos:
		var metadata_label = Label.new()
		if score_data.has("metadata"):
			var final_text = ""
			var metadata = score_data["metadata"]
			if metadata.has("level"):
				final_text = str(metadata["level"])
			else:
				for key in score_data["metadata"]:
					if metadata.size() == 1:
						final_text += str(key) + ": " + str(metadata[key])
					else:
						final_text += str(key) + ": " + str(metadata[key] + ",")
			if final_text.contains("effect"):
				var splitted = final_text.split("effect")
				final_text = splitted[0]
			metadata_label.text = "," + str(final_text)
		else:
			if convert:
				#print(convert_to)
				for key in convert_to:
					metadata_label.text = "," + convert_to[score_data["player_name"]]
			else:
				metadata_label.text = "," + "?????"
		metadata_label.add_theme_font_override("font",load("res://assets/fonts/PressStart2P-Regular.ttf"))
		metadata_label.add_theme_font_size_override("font_size",8)
		metadata_label.show()
		if $"../../..".started_gridding_ishthing == false or ignore == true:
			metadata_vbox.add_child(metadata_label)
	if $"../../..".started_gridding_ishthing == false or ignore == true:
		add_child(metadata_vbox)
	
	for score_data in player_list_with_pos:
		var score_label = Label.new()
		score_label.text = "," + "time: " + $"../../.."._format_time(score_data["score"])
		score_label.add_theme_font_override("font",load("res://assets/fonts/PressStart2P-Regular.ttf"))
		score_label.add_theme_font_size_override("font_size",8)
		score_label.show()
		score_vbox.add_child(score_label)
	add_child(score_vbox)
	
	print("done loading leaderboard")
	$"../../../Loading".hide()

func sort_players_and_add_position(player_list):
	var position = 1
	
	for player in player_list:
		player["position"] = position
		position += 1
	
	return player_list
