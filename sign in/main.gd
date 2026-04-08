extends Control

var is_auto_log = false
@onready var email_label: RichTextLabel = $SignedInPanel/VBoxContainer/email
@onready var user_id_label: RichTextLabel = $SignedInPanel/VBoxContainer/userid
@onready var sign_in_button: Button = $LoginPanel/SignInButton
@onready var sign_out_button: Button = $SignedInPanel/VBoxContainer/SignoutButtonContainer/SignOutButton
@onready var LoginPanel: PanelContainer = $LoginPanel
@onready var SignedInPanel: PanelContainer = $SignedInPanel
@onready var displayname = $SignedInPanel/VBoxContainer/displayname
@onready var login_state_label = $Login_Status

var app_signed_in = false
var email_signed_in = false

var app_name = "app"

var service = "NONE"

func _ready() -> void:
	SupabaseAuth.auth_success.connect(_on_auth_success)
	SupabaseAuth.auth_error.connect(_on_auth_error)
	ItchAuth.user_logged_in.connect(_user_logged_in)
	
	#StartSession
	if FileAccess.file_exists("user://itch_session.dat"):
		save_manager.path = "user://itch_session.dat"
		var itch_dict = save_manager.read_save()
		save_manager.path = "user://lm_data.json"
		ItchAuth.auto_login_user(itch_dict["token"])
	
	
	if FileAccess.file_exists("user://auto_sign_in_email.dat"):
		save_manager.path = "user://auto_sign_in_email.dat"
		var email_dict = save_manager.read_save()
		save_manager.path = "user://lm_data.json"

		email_signed_in = true

		$SignedInPanel.show()
		$SilentWolfAuth.auto_login(email_dict["password"],email_dict["display_name"])
		$SignedInPanel.show()
	
	
	if FileAccess.file_exists("user://auto_sign_in_app.dat"):
		print("AutoLog-ining")
		app_signed_in = true
		save_manager.path = "user://auto_sign_in_app.dat"
		var dict = save_manager.read_save()
		is_auto_log = true
		panel_app_display(dict["data"])
	
	_check_existing_session()
	
	SilentWolf.Auth.sw_session_check_complete.connect(_on_login_complete)
	SilentWolf.Auth.sw_login_complete.connect(_on_login_complete)
	SilentWolf.Auth.sw_logout_complete.connect(_on_logout_complete)
	
	SilentWolf.Auth.auto_login_player()
	
	wait()
	

func wait():
	$chat.disabled = true
	await get_tree().create_timer(2).timeout
	$chat.disabled = false



func _on_auth_success(session: Dictionary):
	_show_authenticated_ui(session)

func _on_auth_error(_error: String):
	_show_login_ui()


func _check_existing_session():
	var session = SupabaseAuth.load_session()
	if session.has("access_token") and session.access_token != "":
		if _is_token_expired(session):
			print("Session expired, need to login again")
			if session.has("refresh_token") and session.refresh_token != "":
				SupabaseAuth.refresh_token(session.refresh_token)
			else:
				_show_login_ui()
		else:
			_show_authenticated_ui(session)
	else:
		_show_login_ui()

func _is_token_expired(session: Dictionary) -> bool:
	if not session.has("expires_in"):
		return false 
	
	var file_path = "user://auth_session.dat"
	if FileAccess.file_exists(file_path):
		var file_time = FileAccess.get_modified_time(file_path)
		var current_time = Time.get_unix_time_from_system()
		var age = current_time - file_time
		
		return age > (session.expires_in - 300)
	
	return false


func _show_login_ui():
	$LoginItch/SignInButton5.disabled = false
	$LoginItch/SignInButton5.text = "Sign in with itch.io"
	$LoginEmail/VBoxContainer/SignUPButton5.disabled = false
	$LoginEmail/VBoxContainer/SignInButton6.disabled = false
	$LoginEmail.show()
	$"application sign in".show()
	$"Image Web".color = "ffffff"
	# Show login button
	LoginPanel.visible = true
	$LoginTwitch/SignInButton4.visible = true
	$Logindiscord/SignInButton2.visible = true
	$LoginPanel/SignInButton.visible = true
	$LoginGithub/SignInButton3.visible = true
	sign_in_button.disabled = false
	$LoginGithub/SignInButton3.disabled = false
	$Logindiscord/SignInButton2.disabled = false
	$LoginTwitch/SignInButton4.disabled = false
	$LoginTwitch/SignInButton4.text = "Sign in with Twitch"
	$Logindiscord/SignInButton2.text = "Sign in with Discord"
	$LoginGithub/SignInButton3.text = "Sign in with Github"
	sign_in_button.text = "Sign in with Google"
	
	# Hide user info panel
	if app_signed_in == false or email_signed_in == false:
		if email_signed_in == false:
			SignedInPanel.visible = false
		print("NOOOOOOOO WHY!!!!!!!!!!!!!!")

func _show_authenticated_ui(session: Dictionary):
	# Hide login button
	LoginPanel.visible = false
	sign_in_button.disabled = true
	
	# Show user info panel with sign out button
	SignedInPanel.visible = true
	
	print("DATA" + str(session) + "/DATA")#provider
	
	var user = session.get("user", {})
	#print(user)
	email_label.text = "Email: " + user.get("email", "Unknown")
	user_id_label.text = "User ID: " + user.get("id", "Unknown")
	displayname.text = "Display Name: " + (user.get("user_metadata", "Unknown").get("name", "Unknown")).split("#")[0]
	$SilentWolfAuth.other_service_create("3p",(user.get("user_metadata", "Unknown").get("name", "Unknown")).split("#")[0])
	#print
	#$SilentWolfAuth.other_service_create(service,(user.get("user_metadata", "Unknown").get("name", "Unknown")).split("#")[0])
	print(email_label.get_theme_default_font_size())
	State.user_info["signed_in"] = true
	State.user_info["username"] = (user.get("user_metadata", "Unknown").get("name", "Unknown")).split("#")[0]
	State.user_info["email"] = user.get("email", "Unknown")
	
	var identities = user["identities"]
	var identities0 = identities[0]
	var identity_data = identities0["identity_data"]
	if identity_data.has("avatar_url"):
		var avatar_url = identity_data["avatar_url"]
	#https://openclipart.org/image/2000px/247320
		State.user_info["image_url"] = avatar_url
		$"Image Web".url = avatar_url
		$"Image Web".download_image()
		$"Image Web".color = "ffffff00"
		print($"Image Web".image_tr.texture)
	else:
		$"Image Web".url = "https://openclipart.org/image/2000px/247320"
		$"Image Web".download_image()
		$"Image Web".color = "ffffff00"
	
	if State.user_info["image_url"] != "":
		print(State.user_info["image_url"])
		$"Image Web".url = State.user_info["image_url"]
		$"Image Web".download_image()
	
	
	
	# Make sure sign out button is visible and connected
	sign_out_button.visible = true
	sign_out_button.disabled = false


func _on_sign_in_button_pressed() -> void:
	sign_in_button.disabled = true
	sign_in_button.text = "Opening browser for authentication..."
	
	$LoginGithub/SignInButton3.hide()
	$Logindiscord/SignInButton2.hide()
	$LoginTwitch/SignInButton4.hide()
	$LoginEmail.hide()
	$LoginItch/SignInButton5.hide()
	$"application sign in".hide()
	SupabaseAuth.provider = "google"
	SupabaseAuth.sign_in_with_google()


func _on_sign_out_button_pressed() -> void:
	ItchAuth.logout_current_user()
	$"Image Web".show()
	$SignedInPanel/VBoxContainer/LineEdit.hide()
	$SignedInPanel/VBoxContainer/change_name.hide()
	$"application sign in".show()
	if app_signed_in == false or email_signed_in == false:
		SupabaseAuth.sign_out()
		_show_login_ui()
	if app_signed_in == true:
		app_signed_in = false
		if FileAccess.file_exists("user://auto_sign_in_app.dat"):
			var save_game_path = "user://auto_sign_in_app.dat"
			DirAccess.remove_absolute(save_game_path)
			$SignedInPanel.hide()
	if email_signed_in == true:
		email_signed_in = false
		if FileAccess.file_exists("user://auto_sign_in_email.dat"):
			var save_game_path = "user://auto_sign_in_email.dat"
			DirAccess.remove_absolute(save_game_path)
			$SignedInPanel.hide()


func _on_sign_in_button_2_pressed():
	$Logindiscord/SignInButton2.disabled = true
	$Logindiscord/SignInButton2.text = "Opening browser for authentication..."
	
	$LoginGithub/SignInButton3.hide()
	$LoginPanel/SignInButton.hide()
	$LoginTwitch/SignInButton4.hide()
	$LoginEmail.hide()
	$"application sign in".hide()
	$LoginItch/SignInButton5.hide()
	SupabaseAuth.provider = "discord"
	SupabaseAuth.sign_in_with_google()
	


func _on_sign_in_button_3_pressed():
	$LoginGithub/SignInButton3.disabled = true
	$LoginGithub/SignInButton3.text = "Opening browser for authentication..."
	
	$Logindiscord/SignInButton2.hide()
	$LoginPanel/SignInButton.hide()
	$LoginTwitch/SignInButton4.hide()
	$LoginEmail.hide()
	$"application sign in".hide()
	$LoginItch/SignInButton5.hide()
	SupabaseAuth.provider = "github"
	SupabaseAuth.sign_in_with_google()


func _process(_delta):
	$"Image Web".visible = $SignedInPanel.visible
	if $SignedInPanel/VBoxContainer/change_name.visible:
		$"Image Web".hide()
	$chat.visible = $SignedInPanel.visible


func _on_sign_in_button_4_pressed():
	$LoginTwitch/SignInButton4.disabled = true
	$LoginTwitch/SignInButton4.text = "Opening browser for authentication..."
	
	$LoginGithub/SignInButton3.hide()
	$Logindiscord/SignInButton2.hide()
	$LoginPanel/SignInButton.hide()
	$LoginEmail.hide()
	$"application sign in".hide()
	$LoginItch/SignInButton5.hide()
	SupabaseAuth.provider = "twitch"
	SupabaseAuth.sign_in_with_google()


func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")


func _on_sign_in_button_6_pressed():
#	get_tree().change_scene_to_file("res://addons/silent_wolf/Auth/Login.tscn")
	$SilentWolfAuth.login_account()


func _on_sign_up_button_5_pressed():
	#get_tree().change_scene_to_file("res://addons/silent_wolf/Auth/Register.tscn")
	$SilentWolfAuth.create_account()


func _on_button_pressed():
	SilentWolf.Auth.logout_player()

func _on_login_complete(sw_result):
	update_login_state_label()

func _on_logout_complete(a, b):
	update_login_state_label()

func update_login_state_label():
	if SilentWolf.Auth.logged_in_player:
		login_state_label.text = "Logged in with email"
	else:
		login_state_label.text = "Not logged in with email"

func _physics_process(delta):
	if $SignedInPanel.visible:
		$LoginEmail.hide()
		$"application sign in".hide()


func panel_app_display(dict: Dictionary):
	if dict.has("name"):
		app_name = dict["name"]
	SignedInPanel.visible = true
	SignedInPanel.visible = true
	if not is_auto_log:
		save_manager.path = "user://app_text_show_data.json"
		save_manager.write_save({
			"header" : "Lm Login Succsess!",
			"body" : "Success THIS IS A NAME you signed in!

	id: " + dict["id"] + "
			
	email: " + dict["email"] + "

	date: " + str(Time.get_datetime_string_from_system())
		})
		save_manager.path = "user://lm_data.json"
	
	is_auto_log = false
	
	LoginPanel.visible = false
	sign_in_button.disabled = true
	
	# Show user info panel with sign out button
	SignedInPanel.visible = true
	
	#print(user)
	if dict.has("email"):
		email_label.text = "Email: " + dict["email"]
	else:
		error_info()

	if dict.has("id"):
		user_id_label.text = "User ID: " + dict["id"]
	else:
		error_info()

	if dict.has("display_name"):
		displayname.text = "Display Name: " + dict["display_name"]
	else:
		error_info()

	print(email_label.get_theme_default_font_size())
	
	State.user_info["signed_in"] = true
	
	if dict.has("display_name"):
		State.user_info["username"] = dict["display_name"]
	else:
		error_info()
	
	if dict.has("email"):
		State.user_info["email"] = dict["email"]
	else:
		error_info()
	
	$"Image Web".color = "ffffff00"
	if dict.has("avatar_url"):
		var avatar_url = dict["avatar_url"]
	#https://openclipart.org/image/2000px/247320
		State.user_info["image_url"] = avatar_url
		$"Image Web".url = avatar_url
		$"Image Web".download_image()
		$"Image Web".color = "ffffff00"
		print($"Image Web".image_tr.texture)
	else:
		$"Image Web".url = "https://openclipart.org/image/2000px/247320"
		$"Image Web".download_image()
		$"Image Web".color = "ffffff00"
	
	if State.user_info["image_url"] != "":
		print(State.user_info["image_url"])
		$"Image Web".url = State.user_info["image_url"]
		$"Image Web".download_image()
	
	
	# Make sure sign out button is visible and connected
	sign_out_button.visible = true
	sign_out_button.disabled = false
	
	SignedInPanel.visible = true


func _on_rich_text_label_meta_clicked(meta):
	print(meta)
	OS.shell_open(str(meta))


func _on_email_sign_up_create_completed(info):
	panel_email_display_CREATE(info)


func _on_email_sign_up_login_completed(info):
	print("info: " + str(info))
	panel_email_display_LOGIN(info)

func panel_email_display_LOGIN(dict):
	var use_formatted = false
	var unformatted_name
	
	var response = await LL_Players.GetPlayersActiveName.new().send()
	if(!response.success):
		# Request failed, handle errors
		use_formatted = true
	else:
		# Request succeeded, use response as applicable in your game logic
		print(response)
		use_formatted = false
		unformatted_name = response["name"]
	
	
	$"Image Web".hide()
	
	SignedInPanel.visible = true
	
	$SignedInPanel/VBoxContainer/LineEdit.show()
	$SignedInPanel/VBoxContainer/change_name.show()
	
	is_auto_log = false
	
	LoginPanel.visible = false
	sign_in_button.disabled = true
	
	# Show user info panel with sign out button
	SignedInPanel.visible = true
	
	#print(user)
	email_label.text = "Email: " + dict["player_identifier"]
	user_id_label.text = "User ID: " + str(dict["player_id"])
	
	var display_name_format_1 = dict["player_identifier"].split("@")
	var display_name_format_2
	var display_name_format_final
	if display_name_format_1[0].contains("."):
		display_name_format_2 = display_name_format_1[0].split(".")
		display_name_format_final = display_name_format_2[0] + " " + display_name_format_2[1]
	else:
		display_name_format_final = display_name_format_2
	
	if use_formatted:
		displayname.text = "Display Name: " + display_name_format_final
	else:
		displayname.text = "Display Name: " + unformatted_name
	print(email_label.get_theme_default_font_size())
	State.user_info["signed_in"] = true
	if use_formatted:
		State.user_info["username"] = unformatted_name
	else:
		State.user_info["username"] = display_name_format_final
	State.user_info["email"] = dict["player_identifier"]
	
	$"Image Web".color = "ffffff00"
#	if dict.has("avatar_url"):
#		var avatar_url = dict["avatar_url"]
#	#https://openclipart.org/image/2000px/247320
#		State.user_info["image_url"] = avatar_url
#		$"Image Web".url = avatar_url
#		$"Image Web".download_image()
#		$"Image Web".color = "ffffff00"
#		print($"Image Web".image_tr.texture)
#	else:
	$"Image Web".url = "https://openclipart.org/image/2000px/247320"
	$"Image Web".download_image()
	$"Image Web".color = "ffffff00"
	
	#if State.user_info["image_url"] != "":
		#print(State.user_info["image_url"])
		#$"Image Web".url = State.user_info["image_url"]
		#$"Image Web".download_image()
	
	
	# Make sure sign out button is visible and connected
	sign_out_button.visible = true
	sign_out_button.disabled = false
	
	SignedInPanel.visible = true

func panel_email_display_CREATE(dict):
	$"Image Web".hide()
	
	var use_formatted = false
	var unformatted_name
	
	$SignedInPanel/VBoxContainer/LineEdit.show()
	$SignedInPanel/VBoxContainer/change_name.show()
	
	var response = await LL_Players.GetPlayersActiveName.new().send()
	if(!response.success):
		# Request failed, handle errors
		use_formatted = true
	else:
		# Request succeeded, use response as applicable in your game logic
		print(response)
		use_formatted = false
		unformatted_name = response["player_name"]
	
	is_auto_log = false
	
	LoginPanel.visible = false
	sign_in_button.disabled = true
	
	# Show user info panel with sign out button
	SignedInPanel.visible = true
	
	#print(user)
	email_label.text = "Email: " + dict["email"]
	user_id_label.text = "User ID: " + str(dict["id"])
	
	var display_name_format_1 = dict["email"].split("@")
	var display_name_format_2
	var display_name_format_final
	if display_name_format_1[0].contains("."):
		display_name_format_2 = display_name_format_1[0].split(".")
		display_name_format_final = display_name_format_2[0] + " " + display_name_format_2[1]
	else:
		display_name_format_final = display_name_format_2
	
	if use_formatted:
		displayname.text = "Display Name: " + display_name_format_final
	else:
		displayname.text = "Display Name: " + unformatted_name
	print(email_label.get_theme_default_font_size())
	State.user_info["signed_in"] = true
	if use_formatted:
		State.user_info["username"] = unformatted_name
	else:
		State.user_info["username"] = display_name_format_final
	State.user_info["email"] = dict["email"]
	
	$"Image Web".color = "ffffff00"
#	if dict.has("avatar_url"):
#		var avatar_url = dict["avatar_url"]
#	#https://openclipart.org/image/2000px/247320
#		State.user_info["image_url"] = avatar_url
#		$"Image Web".url = avatar_url
#		$"Image Web".download_image()
#		$"Image Web".color = "ffffff00"
#		print($"Image Web".image_tr.texture)
#	else:
	$"Image Web".url = "https://openclipart.org/image/2000px/247320"
	$"Image Web".download_image()
	$"Image Web".color = "ffffff00"
	
	#if State.user_info["image_url"] != "":
		#print(State.user_info["image_url"])
		#$"Image Web".url = State.user_info["image_url"]
		#$"Image Web".download_image()
	
	
	# Make sure sign out button is visible and connected
	sign_out_button.visible = true
	sign_out_button.disabled = false
	SignedInPanel.visible = true

#lm.superheroes.official@gmail.com
func _on_change_name_pressed():
	var response = await LL_Players.SetPlayerName.new($SignedInPanel/VBoxContainer/LineEdit.text).send()
	if(!response.success) :
		# Request failed, handle errors
		pass
	else:
		# Request succeeded, use response as applicable in your game logic
		pass
	State.user_info["username"] = $SignedInPanel/VBoxContainer/LineEdit.text
	displayname.text = "Display Name: " + $SignedInPanel/VBoxContainer/LineEdit.text

func error_info():
	save_manager.path = "user://app_text_show_data.json"
	save_manager.write_save({
		"header" : "Error",
		"body" : "error needed info not provided!"})
	save_manager.path = "user://lm_data.json"


func _on_silent_wolf_auth_login_done(data):
	panel_email_display_silentwolf(data)

func panel_email_display_silentwolf(dict):
	save_manager.path = "user://auto_sign_in_email.dat"
	save_manager.write_save({"display_name" : dict["display_name"],"email" : dict["email"],"id" : dict["id"],"password" : dict["password"]})
	save_manager.path = "user://lm_data.json"
	
	
	is_auto_log = false
	
	LoginPanel.visible = false
	sign_in_button.disabled = true
	
	# Show user info panel with sign out button
	SignedInPanel.visible = true
	
	#print(user)
	email_label.text = "Email: " + dict["email"]
	user_id_label.text = "User ID: " + str(dict["id"])
	
	
	displayname.text = "Display Name: " + dict["display_name"]
	print(email_label.get_theme_default_font_size())
	State.user_info["signed_in"] = true
	State.user_info["username"] = dict["display_name"]
	State.user_info["email"] = dict["email"]
	
	$"Image Web".color = "ffffff00"
	if dict.has("avatar_url"):
		var avatar_url = dict["avatar_url"]
	#https://openclipart.org/image/2000px/247320
		State.user_info["image_url"] = avatar_url
		$"Image Web".url = avatar_url
		$"Image Web".download_image()
		$"Image Web".color = "ffffff00"
		print($"Image Web".image_tr.texture)
	else:
		$"Image Web".url = "https://openclipart.org/image/2000px/247320"
		$"Image Web".download_image()
		$"Image Web".color = "ffffff00"
	
	#if State.user_info["image_url"] != "":
		#print(State.user_info["image_url"])
		#$"Image Web".url = State.user_info["image_url"]
		#$"Image Web".download_image()
	
	
	# Make sure sign out button is visible and connected
	sign_out_button.visible = true
	sign_out_button.disabled = false
	SignedInPanel.visible = true

#lm.superheroes.official@gmail.com


func _on_chat_pressed():
	$SilentWolfAuth.start_chat()


func _on_button_3_pressed():
	print("SIGNING IN")
	ItchAuth.login_user("68415425171b6c7c543b29ca2efd3df1")

func _user_logged_in():
	print(ItchAuth.current_user.username)
	print(ItchAuth.current_user.id)
	_show_authenticated_ui_itchio({"id" : ItchAuth.current_user.id,"username" : ItchAuth.current_user.username,"url" : ItchAuth.current_user.user_url,"avatar" : ItchAuth.current_user.cover_url})




func _show_authenticated_ui_itchio(session: Dictionary):
	save_manager.path = "user://itch_session.dat"
	save_manager.write_save({"session" : session,"token" : ItchAuth._token})
	save_manager.path = "user://lm_data.json"
	var save_game_path = "user://auto_sign_in_email.dat"
	DirAccess.remove_absolute(save_game_path)
	save_game_path = "user://auth_session.dat"
	DirAccess.remove_absolute(save_game_path)
	save_game_path = "user://auto_sign_in_app.dat"
	DirAccess.remove_absolute(save_game_path)
	
	# Hide login button
	LoginPanel.visible = false
	sign_in_button.disabled = true
	
	# Show user info panel with sign out button
	SignedInPanel.visible = true
	
	print("DATA" + str(session) + "/DATA")#provider
	
	#print(user)
	email_label.text = "Url: " + session["url"]
	user_id_label.text = "User ID: " + str(session["id"])
	displayname.text = "Display Name: " + session["username"]
	$SilentWolfAuth.other_service_create("3p",session["username"])
	#print
	#$SilentWolfAuth.other_service_create(service,(user.get("user_metadata", "Unknown").get("name", "Unknown")).split("#")[0])
	print(email_label.get_theme_default_font_size())
	State.user_info["signed_in"] = true
	State.user_info["username"] = session["username"]
	State.user_info["email"] =  session["url"]
	
	State.user_info["image_url"] = session["avatar"]
	$"Image Web".url = session["avatar"]
	$"Image Web".download_image()
	$"Image Web".color = "ffffff00"
	print($"Image Web".image_tr.texture)
	
	
	
	# Make sure sign out button is visible and connected
	sign_out_button.visible = true
	sign_out_button.disabled = false


func _on_sign_in_button_5_pressed():
	print("SIGNING IN")
	ItchAuth.login_user("68415425171b6c7c543b29ca2efd3df1")
