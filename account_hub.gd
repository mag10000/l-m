extends Control

var settings_data

@onready var friend_request_scene = preload("res://friend_reques_notification.tscn")
var notifications

func _ready():
	#SilentWolf.Scores.save_score("TEST", 10, "friend_requests_new")
	#retrive_scores("friend_requests_new")
	pass

func check_for_player_notification(player_data):
	#print("checklindfjamng gngngngnngngn")
	if $notifications/VBoxContainer.get_children().size() == 0:
		#print("what THE FU*K")
		if notifications:
			if notifications != []:
				for item in notifications:
					var metadata = item["metadata"]
					if metadata.has("to"):
						if metadata["to"] == player_data["display_name"]:
							var instance = friend_request_scene.instantiate()
							instance.text = "(friend request) " + metadata["from"]
							instance.id = int(metadata["id"])
							$notifications/VBoxContainer.add_child(instance)
							$HBoxContainer/notifications.icon = load("res://assets/notification2.png")
	#if $notifications/VBoxContainer.get_children().size() == 0:
	#	var label = RichTextLabel.new()
	#	label.bbcode_enabled = true
	#	label.custom_minimum_size.y = 50
	#	label.add_theme_font_override("normal_font",load("res://assets/fonts/PressStart2P-Regular.ttf"))
	#	label.text = "No notifications"
	#	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	#	$notifications/VBoxContainer.add_child(label)

func check_for_friends(player_data):
	if $notifications/VBoxContainer.get_children().size() == 1:
		var friends
		var sw_result: Dictionary = await SilentWolf.Scores.get_scores(0,"friends").sw_get_scores_complete
		friends = sw_result.scores
		for friend in friends:
			var metadata = friend["metadata"]
			if metadata.has("friend_1"):
				if metadata["friend_1"] == player_data["display_name"]:
					var label = RichTextLabel.new()
					label.bbcode_enabled = true
					label.custom_minimum_size.y = 30
					label.add_theme_font_override("normal_font",load("res://assets/fonts/PressStart2P-Regular.ttf"))
					label.text = metadata["friend_2"]
					label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
					$friends/VBoxContainer.add_child(label)
				if metadata["friend_2"] == player_data["display_name"]:
					var label = RichTextLabel.new()
					label.bbcode_enabled = true
					label.custom_minimum_size.y = 30
					label.add_theme_font_override("normal_font",load("res://assets/fonts/PressStart2P-Regular.ttf"))
					label.text = metadata["friend_1"]
					label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
					$friends/VBoxContainer.add_child(label)
	#if $friends/VBoxContainer.get_children().size() == 1:
	#	var label = RichTextLabel.new()
	#	label.bbcode_enabled = true
	#	label.custom_minimum_size.y = 50
	#	label.add_theme_font_override("normal_font",load("res://assets/fonts/PressStart2P-Regular.ttf"))
	#	label.text = "No friends"
	#	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	#	$friends/VBoxContainer.add_child(label)
 

func retrive_scores(board,hide_load=true):
	$"../Loading".show()
	var sw_result: Dictionary = await SilentWolf.Scores.get_scores(0,board).sw_get_scores_complete
	notifications = sw_result.scores
	print(notifications)
	if hide_load:
		$"../Loading".hide()


#func _on_silent_wolf_auth_login_done(data):
	
#	State.user_info["username"] = data["display_name"]
#	State.user_info["email"] = data["email"]
#	State.user_info["image_url"] = data["avatar_url"]
#	
	#$account/VBoxContainer/code.text = "Friend Code: " + data["friend_id"]
#	$account/VBoxContainer/ID.text = "ID: " + data["id"]
	
#	print("Showing account hub")
#	show()
#	#$".".show()
#	show()
	#retrive_scores("friend_requests_new",false)
#	$"../Loading".show()
#	await get_tree().create_timer(2.5).timeout
#	$"../Loading".hide()
	
	#print("notifications: " + str(notifications))
	
#	check_for_player_notification(data)
#	check_for_friends(data)
	
	#"display_name": $Create/VBoxContainer/username.text,
	#"email" :  $Create/VBoxContainer/email.text,
	#"id" : id,
	#"avatar_url" : "https://img.itch.zone/aW1nLzE3NTYxOTY2LnBuZw==/315x250%23c/VL89iE.png",
	#"friend_id" : account_metadata["friend_id"]


func _on_send_request_pressed():
	$"friends/request panel".show()


func _on_send_request_to_id_pressed():
	var found = false
	var player_name = ""
	for score in $"..".scores:
		var metadata = score["metadata"]
		if metadata.has("friend_id"):
			if metadata["friend_id"] == $"friends/request panel/ID".text:
				found = true
				player_name = score["player_name"]
	if found:
		SilentWolf.Scores.save_score(Time.get_datetime_string_from_system(), int(Time.get_datetime_string_from_system()), "friend_requests_new", {
			"from" : State.user_info["username"],
			"to" : player_name,
			"id" : randi_range(10000000,99999999)
		})
		$"friends/request panel".hide()
	else:
		$"friends/request panel/Label".show()
		await get_tree().create_timer(2).timeout
		$"friends/request panel/Label".hide()
