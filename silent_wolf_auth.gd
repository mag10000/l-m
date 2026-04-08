extends Control

var other_service_on = true

var scores

signal login_done(data : Dictionary)

var player_data

# Called when the node enters the scene tree for the first time.
func _ready():
	retrive_scores()
	show()

func start_chat():
	$chat.start_chat(player_data)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func retrive_scores():
	$Loading.show()
	var sw_result: Dictionary = await SilentWolf.Scores.get_scores(0,"Auth").sw_get_scores_complete
	scores = sw_result.scores
	print(scores)
	$Loading.hide()

func create_account():
	$Create.show()

func login_account():
	$login.show()


func error(text,type):
	if type == "create":
		$Create/VBoxContainer/Label.show()
		$Create/VBoxContainer/Label.text = text
		await get_tree().create_timer(2.5).timeout
		$Create/VBoxContainer/Label.hide()
	else:
		$login/VBoxContainer/Label.show()
		$login/VBoxContainer/Label.text = text
		await get_tree().create_timer(2.5).timeout
		$login/VBoxContainer/Label.hide()


func _on_submit_create_pressed():
	retrive_scores()
	if $Create/VBoxContainer/Password.text == $"Create/VBoxContainer/re-Password".text:
		#create account
		if $Create/VBoxContainer/Password.text.length() < 8:
			error("Password too short!","create")
		else:
			var username_taken = false
			if scores:
				for account in scores:
					if account["player_name"] != $Create/VBoxContainer/username.text:
						username_taken = false
					else:
						username_taken = true
						error("Username Taken!","create")
			if username_taken:
				error("Username Taken!","create")
			else:
				error("Creating account...","create")
				var ID = str(randi_range(1,100)) + str(int(Time.get_datetime_string_from_system())) + str(randi_range(1,100))
				var sw_result : Dictionary = await SilentWolf.Scores.save_score($Create/VBoxContainer/username.text,2026, "Auth",{"email" : $Create/VBoxContainer/email.text,"id" : ID,"friend_id" : "ERROR:CODE{1}","password" : $Create/VBoxContainer/Password.text.sha256_text()}).sw_save_score_complete
				error("Done!","create")
				
				player_data = {
					"display_name": $Create/VBoxContainer/username.text,
					"email" : $Create/VBoxContainer/email.text,
					"id" : ID,
					"avatar_url" : "https://img.itch.zone/aW1nLzE3NTYxOTY2LnBuZw==/315x250%23c/VL89iE.png",
					"friend_id" : "blah",
					"password" : $Create/VBoxContainer/Password.text.sha256_text(),
				}
				login_done.emit(player_data)
				$Create.hide()
	else:
		error("Password and Re-enter Password are diffrent!","create")
#"email" : account_metadata["email"],
#"id" : account_metadata["id"],
#"friend_id" : account_metadata["friend_id"],
#"password" : account_metadata["password"],


func _on_submit_login_pressed():
	var account_exists = false
	var password = ""
	var account_metadata = {}
	var display_name = ""
	retrive_scores()
	await get_tree().create_timer(2).timeout
	retrive_scores()
	await get_tree().create_timer(2).timeout
	for score in scores:
		if score["player_name"] == $login/VBoxContainer/username.text:
			account_exists = true
			var metadata = score["metadata"]
			password = metadata["password"]
			account_metadata = metadata
			display_name = score["player_name"]
	if account_exists:
		print("account_exists")
		if $login/VBoxContainer/Password.text.sha256_text() == password:
			player_data = {
					"display_name": display_name,
					"email" : account_metadata["email"],
					"id" : account_metadata["id"],
					"avatar_url" : "https://img.itch.zone/aW1nLzE3NTYxOTY2LnBuZw==/315x250%23c/VL89iE.png",
					"friend_id" : account_metadata["friend_id"],
					"password" : account_metadata["password"],
			}
			login_done.emit(player_data)
			retrive_scores()
			$login.hide()
		else:
			error("password/email wrong!","login")
	else:
		error("Account does not exist!","login")

func auto_login(_password,username):
	var account_exists = false
	var password = ""
	var account_metadata = {}
	var display_name = ""
	retrive_scores()
	await get_tree().create_timer(2).timeout
	retrive_scores()
	await get_tree().create_timer(2).timeout
	for score in scores:
		if score["player_name"] == username:
			account_exists = true
			var metadata = score["metadata"]
			password = metadata["password"]
			account_metadata = metadata
			display_name = score["player_name"]
	if account_exists:
		print("account_exists")
		if _password == password:
			player_data = {
					"display_name": display_name,
					"email" : account_metadata["email"],
					"id" : account_metadata["id"],
					"avatar_url" : "https://img.itch.zone/aW1nLzE3NTYxOTY2LnBuZw==/315x250%23c/VL89iE.png",
					"friend_id" : account_metadata["friend_id"],
					"password" : _password
			}
			login_done.emit(player_data)
			retrive_scores()
			$login.hide()
		else:
			error("password/email wrong!","login")
	else:
		error("Account does not exist!","login")


func get_object_from_numb(number):
	if number == 1:
		return "pizza"
	if number == 2:
		return "cat"
	if number == 3:
		return "taco"
	if number == 4:
		return "Rubik'sCube"
	if number == 5:
		return "phone"
	if number == 6:
		return "67kid"
	if number == 7:
		return "67kid"
	if number == 8:
		return "clock"
	if number == 9:
		return "dog"
	if number == 10:
		return "human"
	if number == 11:
		return "game"
	if number == 12:
		return "video"
	if number == 13:
		return "tree"
	if number == 14:
		return "MathKid"
	if number == 15:
		return "anurag"


func _on_friends_pressed():
	$"account hub/friends".show()
	$"account hub/notifications".hide()
	$"account hub/account".hide()
	#$"account hub".check_for_friends(player_data)


func _on_notifications_pressed():
	$"account hub/notifications".show()
	$"account hub/friends".hide()
	$"account hub/account".hide()
	$"account hub".check_for_player_notification(player_data)


func _on_account_pressed():
	$"account hub/account".show()
	$"account hub/friends".hide()
	$"account hub/notifications".hide()
	

func other_service_create(service,player_name):
		await get_tree().create_timer(1).timeout
		if not scores:
			await get_tree().create_timer(1).timeout
			other_service_create(service,player_name)
			return
		if not scores.has(player_name + "(" + service + ")"):
			var username_taken = false
			
			await get_tree().create_timer(2).timeout
			
			if scores:
				for score in scores:
					if score["player_name"] == player_name + "(" + service + ")":
						username_taken = true
			
			var id = "x945z12345@)@%-^&" + str(randi_range(1,1000348203783023829)) + str( int( Time.get_datetime_string_from_system() ) )
			
			var random_object_numb = randi_range(1,15)
			var object = get_object_from_numb(random_object_numb)
			
			var friend_id = "2025-" + str(randi_range(1000,9999)) + "-" + str(object)
			
			if not username_taken:
				SilentWolf.Scores.save_score(player_name + "(" + service + ")", int(Time.get_datetime_string_from_system()), "Auth", {
					"password" : "1",
					"email" : "1",
					"id" : id,
					"date of creation" : Time.get_datetime_string_from_system(),
					"type" : service,
					"friend_id" : friend_id
				})
				
				player_data = {
					"display_name": player_name + "(" + service + ")",
					"email" : "1",
					"id" : id,
					"avatar_url" : "https://img.itch.zone/aW1nLzE3NTYxOTY2LnBuZw==/315x250%23c/VL89iE.png",
					"friend_id" : friend_id,
					"password" : "1"
			}
			else:
				player_data = {
					"display_name": player_name + "(" + service + ")",
					"email" : "1",
					"id" : id,
					"avatar_url" : "https://img.itch.zone/aW1nLzE3NTYxOTY2LnBuZw==/315x250%23c/VL89iE.png",
					"friend_id" : friend_id,
					"password" : "1"
			}
				#login_done.emit(player_data)
				$Create.hide()
				retrive_scores()


func _on_close_pressed():
	$chat.hide()


func _on_rich_text_label_2_meta_clicked(meta):
	OS.shell_open(str(meta))


func _on_rich_text_label_meta_clicked(meta):
	OS.shell_open(str(meta))
