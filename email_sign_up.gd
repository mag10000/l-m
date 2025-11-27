extends Control

signal create_completed(info : Dictionary)
signal login_completed(info : Dictionary)

var email_code

var wait_for_verification = false

var temp_response

# Called when the node enters the scene tree for the first time.
func _ready():
	pass



func _create_account():
	show()
	$Create.show()
	$login.hide()

func _login_account():
	show()
	$Create.hide()
	$login.show()


func error(text,type):
	if wait_for_verification == false:
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


func _on_rich_text_label_meta_clicked(meta):
	print(meta)
	OS.shell_open(str(meta))


func _on_rich_text_label_2_meta_clicked(meta):
	print(meta)
	OS.shell_open(str(meta))


func _on_submit_create_pressed():
	error("creating account...","create")
	if $Create/VBoxContainer/Password.text.length() < 8:
		#show "too short" error
		error("password too short!","create")
	else:
		#_email, _password, _remember
		#succsess
		#check if password and re-enter password are the same
		if $"Create/VBoxContainer/re-Password".text == $Create/VBoxContainer/Password.text:
			var response = await LL_WhiteLabel.SignUp.new($Create/VBoxContainer/email.text, $Create/VBoxContainer/Password.text).send()
			if(!response.success) :
				# Request failed, handle errors
				print(response)
				var _error = response["error_data"]
				error(str(_error["message"]),"create")
			else:
				print(response)
				# Request succeeded, use response as applicable in your game logic
				# Remember to remind the player to verify their email to be able to utilize this new account
				#create_completed.emit(response)
				#var email_response = await LL_WhiteLabel.RequestVerification.new("an-email").send()
				#wait_for_verification = true
				#error("waiting for verification","create")
				#if(!email_response.success) :
				#	# Request failed, handle errors
				#	pass
				#else:
				#	print("sucsess!!")
				#	pass
				var login_response = await LL_WhiteLabel.LoginAndStartSession.new($Create/VBoxContainer/email.text, $Create/VBoxContainer/Password.text,true).send()
				if(!login_response.success) :
					var _error = login_response["error_data"]
					error(str(_error["message"]),"login")
					if str(_error["message"]) == "account not verified":
						wait_for_verification = true
						temp_response = response
				else:
					print(login_response)
					login_completed.emit(login_response)
				

func _physics_process(delta):
	if wait_for_verification == true:
		$Create/VBoxContainer/Label.show()
		$Create/VBoxContainer/Label.text = "Waiting for email verification..."
		await get_tree().create_timer(0.5).timeout
		var login_response = await LL_WhiteLabel.LoginAndStartSession.new($Create/VBoxContainer/email.text, $Create/VBoxContainer/Password.text,true).send()
		if(!login_response.success) :
			var _error = login_response["error_data"]
			error(str(_error["message"]),"login")
		else:
			print(login_response)
			login_completed.emit(login_response)
			after(temp_response)


func after(response):
				$Create/VBoxContainer/Label.hide()
				$Create/VBoxContainer/Label.text = ""
				$Create.hide()
				hide()
				wait_for_verification = false
				var display_name_format_1 = response["email"].split("@")
				var display_name_format_2
				var display_name_format_final
				if display_name_format_1[0].contains("."):
					display_name_format_2 = display_name_format_1[0].split(".")
					display_name_format_final = display_name_format_2[0] + " " + display_name_format_2[1]
				else:
					display_name_format_final = display_name_format_2
				
				var name_response = await LL_Players.SetPlayerName.new(display_name_format_final).send()
				if(!name_response.success) :
					# Request failed, handle errors
					pass
				else:
					# Request succeeded, use response as applicable in your game logic
					pass
					
				save_manager.path = "user://auto_sign_in_email.dat"
				save_manager.write_save({"email" : response["email"]})
				save_manager.path = "user://lm_data.json"


func _on_submit_login_pressed():
	error("logging in...","login")
	var response = await LL_WhiteLabel.LoginAndStartSession.new($login/VBoxContainer/email.text, $login/VBoxContainer/Password.text,true).send()
	if(!response.success) :
		var _error = response["error_data"]
		error(str(_error["message"]),"login")
	else:
		print(response)
		login_completed.emit(response)
		$login.hide()
		hide()
		save_manager.path = "user://auto_sign_in_email.dat"
		save_manager.write_save({"email" : response["player_identifier"]})
		save_manager.path = "user://lm_data.json"
