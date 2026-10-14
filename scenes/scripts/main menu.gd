extends Node2D

var mod_info = false

var doing_auto_load = false

var auto_load_exist = true

var html

var save_path = "user://variable.json"

var mod_on = ""

var version = "v" + ProjectSettings.get_setting("application/config/version")
@warning_ignore("unused_private_class_variable")
var _1_prees = false

var date_dict = Time.get_date_dict_from_system()  

var current_month = date_dict["month"]

var current_day = date_dict["day"]

func _on_button_pressed():
	#State.save_menu_place_change_time = true
	##$Popup.visible = true
	State.player_2_in = false
	State.player_3_in = false
	get_tree().change_scene_to_file(State.save_menu_scene) 

func _on_button_2_pressed():
	#if State.user_info["signed_in"] == false:
	save_manager.write_save(save())
	#else:
		#_cloud_save_data(save())
	GDSync.quit()


func load_mod():
	var user = OS.get_environment("USERNAME")
	var dir = DirAccess.open("C:\\Users\\" + user + "\\Documents\\LMdlc")
	print(dir.get_files())
	for file in dir.get_files():
		if file.contains(".pck"):
			#if FileAccess.file_exists("C:\\Users\\" + user + "\\Documents\\LMdlc\\" + file + "\\info.txt"):
			print(file + " mod load succesfull")
			
			ProjectSettings.load_resource_pack("C:\\Users\\" + user + "\\Documents\\LMdlc\\" + file,true)
			State.mod_on = file
			if FileAccess.file_exists("res://info.txt"):
				print("info exists")
				var info = "res://info.txt"
				var info_file = FileAccess.open(info, FileAccess.READ)
				$"update guide/body".text = info_file.get_as_text()
				#if $"update guide/body".text != "":
				mod_info = true
				#else:
			if FileAccess.file_exists("res://header.txt"):
				print("header exists")
				var header = "res://header.txt"
				var header_file = FileAccess.open(header, FileAccess.READ)
				$"update guide/header".text = header_file.get_as_text()
			else:
				$"update guide/header".text = file + " mod"
		else:
			print(file + " mod load unsuccesfull")
	var runtime = load("res://mod runtime.tscn")
	var runtime_node = runtime.instantiate()
	State.add_child(runtime_node)
	for node in DirAccess.get_files_at("res://autonodes"):
		if node.get_extension() == "tscn":
			var autonode_scene = load(node)
			var autonode_node = autonode_scene.instantiate()
			State.add_child(autonode_node)
	#ProjectSettings.load_resource_pack("")
	#ProjectSettings.load_resource_pack("C:\\Users\\magnu\\Documents\\LMdlc\\farmer.zip",true)



func _process(_delta):
	$AnimatedSprite2D2.visible = false
	if Input.is_action_just_pressed("ui_accept"):
		$AcceptDialog.hide()
	
	
	
	if State.arcade == true:
		$Button2.visible = false
		$Button3.visible = false
		$AnimatedSprite2D2.visible = false
		$AnimatedSprite2D.visible = false
		$Button4.visible = false
		$Button5.visible = false
		$Button6.visible = false
		$Button7.visible = false
		$save.visible = false
		$load.visible = false
		$mobile.visible = false
		$arcade.visible = false
	
	
	if current_month == 12:
		$GPUParticles2D.emitting = true
	if current_month == 10 && current_day == 32:
		$MainMenuArtSpooky.visible = true
	if State.fist_time_played == true:
		$Popup/HBoxContainer/load_save.disabled = true
	if State.fist_time_played == false:
		$Popup/HBoxContainer/load_save.disabled = false

#magnus

	if State.loginperson == ("none"):
		#$Button7.disabled = true
		$MainMenuArt/ColorRect4.visible = false
		$AnimatedSprite2D2.play("new_animation")
		$AnimatedSprite2D.play("default")
		$MainMenuArt/ColorRect5.visible = false
	else:
		$AnimatedSprite2D2.play("default")
		$AnimatedSprite2D.play("new_animation")
	if State.user_info["signed_in"]:
		$shop_button.disabled = false
	else:
		$shop_button.disabled = true

func _on_button_4_pressed():
	get_tree().change_scene_to_file("res://translate/translate.tscn")

func _ready():
	GamepadCursor.use_gamepad_mouse = true
	if FileAccess.file_exists("user://auth_session.dat") && State.user_info["signed_in"] == false:
		get_tree().change_scene_to_file("res://sign in/main.tscn")
	if FileAccess.file_exists("user://auto_sign_in_email.dat") && State.user_info["signed_in"] == false:
		get_tree().change_scene_to_file("res://sign in/main.tscn")
	if FileAccess.file_exists("user://auto_sign_in_app.dat") && State.user_info["signed_in"] == false:
		get_tree().change_scene_to_file("res://sign in/main.tscn")
	if FileAccess.file_exists("user://itch_session.dat") && State.user_info["signed_in"] == false:
		get_tree().change_scene_to_file("res://sign in/main.tscn")

	#if State.user_info["signed_in"] == true:
		#if State.cloud_load == false:
			#State.cloud_load = true
			#_cloud_load_data()
	State.kill_LeaderboardTimer()
	load_mod()
	State.version = version
	$ver.text = version
	if State.beta_test == true:
		$beta.show()
	print("local code : " + TranslationServer.get_locale())
	if TranslationServer.get_locale().contains("es"):
		print($Button.size)
		$Button2.size = Vector2(136.0, 31.0)
		$Button.position.x -= 48
		$save.position.x -= 29 * 2 - 4
	if TranslationServer.get_locale().contains("cmn") or TranslationServer.get_locale().contains("ja"):
		$Button.add_theme_font_size_override("font_size",12)
		$Button2.add_theme_font_size_override("font_size",12)
		$RichTextLabel.add_theme_font_size_override("normal_font_size",12)
		$arcade.add_theme_font_size_override("font_size",12)
		$Button3.add_theme_font_size_override("font_size",12)
		$save.add_theme_font_size_override("font_size",12)
		$load.add_theme_font_size_override("font_size",12)
		$Translate.add_theme_font_size_override("font_size",12)
	if TranslationServer.get_locale().contains("ko"):
		$Button.add_theme_font_size_override("font_size",24)
		$Button2.add_theme_font_size_override("font_size",24)
		$RichTextLabel.add_theme_font_size_override("normal_font_size",24)
		$arcade.add_theme_font_size_override("font_size",24)
		$Button3.add_theme_font_size_override("font_size",24)
		$save.add_theme_font_size_override("font_size",24)
		$load.add_theme_font_size_override("font_size",24)
		$Translate.add_theme_font_size_override("font_size",24)
		$arcade.position.x -= 21.3
	if TranslationServer.get_locale().contains("fr"):
		$Button.position.x -= 64
		$Button2.size = Vector2(152.0, 31.0)
		$Button3.position = Vector2(5.0,61.0)
		print($Button.size)
		$save.position.x -= 86
		$load.position.x -= 26
		print($save.size)
		$load.size = Vector2(184.0, 31.0)
	if TranslationServer.get_locale().to_lower().contains("br"):
		$Button3.position = Vector2(-12.0,61.0)
		$Button.position.x -= 36
		$Button2.size = $Button.size
	
	
	
	#for cloud save: && State.user_info["signed_in"] == false
	
	if FileAccess.file_exists("user://lm_data.json") && State.loaded == false:
		State.loaded = true
		doing_auto_load = true
		if State.auto_load == true:
			load_data(save_manager.read_save())
		else:
			State.loaded = false
			doing_auto_load = false
	
	
	
	#load("res://test_mod.gd")
	
	
	var testMod = preload("res://test_mod.gd")
	var testModInstance = testMod.new()
	testModInstance.test_func()
	#testMod.test_func()
	
	#if OS.has_feature("web_android") or OS.has_feature("web_ios"):
		#State.mobile = true
	
	#if OS.get_name() == "Windows":
		#if FileAccess.file_exists("C:\\Users\\" + OS.get_environment("USERNAME") + "\\Documents\\LMdlc\\MoreLevels\\New Text Document.txt"):
			#OS.shell_open("C:\\Users\\" + OS.get_environment("USERNAME") + "\\Documents\\LMdlc\\MoreLevels\\New Text Document.txt")
	
	if State.fist_time_played == true && State.beta_test == false:
		$AcceptDialog.popup()
	if OS.get_name() == "Windows":
		var user = OS.get_environment("USERNAME")
		var folder_path = "C:\\Users\\"+user+"\\Documents\\LMdlc"
		if FileAccess.file_exists(folder_path):
			#get_tree().quit()
			pass
		else:
			DirAccess.make_dir_absolute(folder_path)
		DirAccess.make_dir_absolute("C:\\Users\\"+user+"\\Documents\\LMJumpSound")
		
		$AcceptDialog.dialog_text = tr("Hello") + " " + user + tr(" and welcome to lm superheroes!")

		if FileAccess.file_exists(folder_path + "MoreLevels"):
			GDSync.quit()
	if State.window_saftey == false:
		var user = OS.get_environment("USERNAME")
		var folder_path = "C:\\Users\\"+user+"\\Documents\\LMdlc"
		if FileAccess.file_exists(folder_path):
			GDSync.quit()
		else:
			DirAccess.make_dir_absolute(folder_path)
		DirAccess.make_dir_absolute("C:\\Users\\"+user+"\\Documents\\LMJumpSound")
		
		$AcceptDialog.dialog_text = tr("Hello") + user + tr(" and welcome to lm superheroes!")

		if FileAccess.file_exists(folder_path + "MoreLevels"):
			GDSync.quit()

	save_manager.path = "user://lm_data.json"

func _on_load_save_pressed():
	State.player_2_in = false
	State.player_3_in = false
	get_tree().change_scene_to_file(State.save_menu_scene)


func _on_new_save_pressed():
	State.player_2_in = false
	State.player_3_in = false
	get_tree().change_scene_to_file(State.save_menu_scene)


func _on_button_5_pressed():
	State.loginperson = ("none")
	get_tree().change_scene_to_file("res://scenes/acount_scene.tscn")


func _on_button_7_pressed():
	get_tree().change_scene_to_file("res://lm_shop.tscn")

func _on_save_pressed():
	#if State.user_info["signed_in"] == false:
	save_manager.write_save(save())
	#else:
		#_cloud_save_data(save())
	

func _on_load_pressed():
	#if State.user_info["signed_in"] == false:
	load_data(save_manager.read_save())
	#else:
		#_cloud_load_data()
	#load_data()

func save():
	var save_dict = {
	"mobile" : State.mobile,
	"run_mode" : State.run_mode,
	"invis" : State.invis,
	"auto_load" : State.auto_load,
	"animal_pack_bought" : State.animal_pack_bought, 
	"save_menu_scene" : State.save_menu_scene, 
	"purple_pack_bought" : State.purple_pack_bought, 
	"mod" : State.mod, 
	"lmcoins" : State.lmcoins, 
	"shop_color" : State.shop_color,
	"fist_time_played" : State.fist_time_played,
	"co_op_unlocked" : State.co_op_unlocked, 
	"money" : State.money, 
	"on_a_jacoblevel" : State.on_a_jacoblevel, 
	"level_one_done" : State.level_one_done, 
	"cutscene1_done" : State.cutscene1_done, 
	"tuturiol_level_done" : State.tuturiol_level_done, 
	"jacob_level_1_done" : State.jacob_level_1_done, 
	"boss_fight_1_done" : State.boss_fight_1_done, 
	"level_two_done" : State.level_two_done, 
	"cutscene_4" : State.cutscene_4, 
	"cutscene_5_done" : State.cutscene_5_done, 
	"strange_signal_level_done" : State.strange_signal_level_done, 
	"level_three_done" : State.level_three_done, 
	"level_four_done" : State.level_four_done, 
	"level_five_done" : State.level_five_done, 
	"level_6_done" : State.level_6_done ,
	"level_7_done" : State.level_7_done,
	"level_8_done" : State.level_8_done,
	"portal_done" : State.portal_done,
	"world_2_level_1_done" : State.world_2_level_1_done,
	"version" : version,
	"card_data" : Cards.card_data,
	"show_leaderboard_timer" : State.show_leaderboard_timer,
	"app_sign_ins" : State.app_sign_ins,
}
	print (save_dict)
	return save_dict

func load_data(load_dict):
	if FileAccess.file_exists("user://lm_data.json"):
		print("load1")
		if not load_dict.has("auto_load"):
			load_dict["auto_load"] = true
		
		#"mobile" : State.mobile,
		#"run_mode" : State.run_mode,
		#"invis" : State.invis,
		#"auto_load" : State.auto_load,
		
		if load_dict.has("auto_load"):
			print("load2")
			if load_dict["auto_load"] == true or not doing_auto_load:
				doing_auto_load = false
				print("load3")
				if load_dict.has("auto_load"):
					State.auto_load = load_dict["auto_load"]
				if load_dict.has("run_mode"):
					State.run_mode = load_dict["run_mode"]
				if load_dict.has("invis"):
					State.invis = load_dict["invis"]
				if load_dict.has("mobile"):
					State.mobile = load_dict["mobile"]
				if load_dict.has("animal_pack_bought"):
					State.animal_pack_bought = load_dict["animal_pack_bought"]
				if load_dict.has("save_menu_scene"):
					State.save_menu_scene = load_dict["save_menu_scene"]
				if load_dict.has("purple_pack_bought"):
					State.purple_pack_bought = load_dict["purple_pack_bought"]
				if load_dict.has("mod"):
					State.mod = load_dict["mod"]
				if load_dict.has("lmcoins"):
					State.lmcoins = load_dict["lmcoins"]
				if load_dict.has("shop_color"):
					State.shop_color = load_dict["shop_color"]
				if load_dict.has("fist_time_played"):
					State.fist_time_played = load_dict["fist_time_played"]
				if load_dict.has("co_op_unlocked"):
					State.co_op_unlocked = load_dict["co_op_unlocked"]
				if load_dict.has("money"):
					State.money = load_dict["money"]
				if load_dict.has("on_a_jacoblevel"):
					State.on_a_jacoblevel = load_dict["on_a_jacoblevel"]
				if load_dict.has("level_one_done"):
					State.level_one_done = load_dict["level_one_done"]
				if load_dict.has("cutscene1_done"):
					State.cutscene1_done = load_dict["cutscene1_done"]
				if load_dict.has("tuturiol_level_done"):
					State.tuturiol_level_done = load_dict["tuturiol_level_done"]
				if load_dict.has("jacob_level_1_done"):
					State.jacob_level_1_done = load_dict["jacob_level_1_done"]
				if load_dict.has("boss_fight_1_done"):
					State.boss_fight_1_done = load_dict["boss_fight_1_done"]
				if load_dict.has("level_two_done"):
					State.level_two_done = load_dict["level_two_done"]
				if load_dict.has("cutscene_4"):
					State.cutscene_4 = load_dict["cutscene_4"]
				if load_dict.has("cutscene_5_done"):
					State.cutscene_5_done = load_dict["cutscene_5_done"]
				if load_dict.has("strange_signal_level_done"):
					State.strange_signal_level_done = load_dict["strange_signal_level_done"]
				if load_dict.has("level_three_done"):
					State.level_three_done = load_dict["level_three_done"]
				if load_dict.has("level_four_done"):
					State.level_four_done = load_dict["level_four_done"]
				if load_dict.has("level_five_done"):
					State.level_five_done = load_dict["level_five_done"]
				if load_dict.has("level_6_done"):
					State.level_6_done  = load_dict["level_6_done"]
				if load_dict.has("level_7_done"):
					State.level_7_done  = load_dict["level_7_done"]
				if load_dict.has("level_8_done"):
					State.level_8_done  = load_dict["level_8_done"]
				if load_dict.has("portal_done"):
					State.level_8_done  = load_dict["portal_done"]
				if load_dict.has("world_2_level_1_done"):
					State.world_2_level_1_done  = load_dict["world_2_level_1_done"]
				if load_dict.has("card_data"):
					Cards.card_data  = load_dict["card_data"]
				if load_dict.has("show_leaderboard_timer"):
					State.show_leaderboard_timer  = load_dict["show_leaderboard_timer"]
				if load_dict.has("app_sign_ins"):
					State.app_sign_ins  = load_dict["app_sign_ins"]
			else: 
				pass
	#for key in load_dict:
	#	State.key = load_dict[key]
	#"show_leaderboard_timer" : State.show_leaderboard_timer,
	#"app_sign_ins" : State.app_sign_ins,
func _on_mobile_pressed():
	State.mobile = !State.mobile


func _on_button_3_pressed():
	get_tree().change_scene_to_file("res://settings.tscn")


func _on_arcade_pressed():
	$Button2.visible = false
	$Button3.visible = false
	$AnimatedSprite2D2.visible = false
	$AnimatedSprite2D.visible = false
	$Button5.visible = false
	$Button6.visible = false
	$Button8.visible = false
	$save.visible = false
	$load.visible = false
	$mobile.visible = false
	$arcade.visible = false
	State.arcade = true


func _on_timer_timeout():
	GDSync.quit()


func _on_button_8_pressed():
	State.beta_test = true
	$beta.show()


func _on_accept_dialog_confirmed():
	ver_check()
	if mod_info == true:
		$"update guide".show()
		$AudioStreamPlayer2D.stop()


func _on_accept_dialog_canceled():
	ver_check()
	if mod_info == true:
		$"update guide".show()
		$AudioStreamPlayer2D.stop()


func ver_check():
	ver_load(save_manager.read_save())


func ver_load(load_dict):
	if FileAccess.file_exists(save_manager.path):
#		print(load_dict[version])
		if load_dict.has("version"):
#			print(str(load_dict[version]))
			var saved_ver = load_dict["version"] #str(load_dict[version])
			if saved_ver != version:
				$"update guide".show()
				$AudioStreamPlayer2D.stop()
		else:
			print("yayaaaa")
			$"update guide".show()
			$AudioStreamPlayer2D.stop()
	else: 
		$"update guide".show()
		$AudioStreamPlayer2D.stop()
		save_manager.write_save(save())


func _on_body_meta_clicked(meta):
	print(meta)
	OS.shell_open(str(meta))


func _on_close_pressed():
	save_manager.write_save(save())
	$"update guide".hide()
	$AudioStreamPlayer2D.play()


func _on_leaderboard_pressed():
	get_tree().change_scene_to_file("res://online_leaderboard.tscn")

func _cloud_save_data(data : Dictionary):
	if State.user_info["signed_in"] == true:
		var sw_result = await SilentWolf.Players.save_player_data(State.user_info["username"], data).sw_save_player_data_complete
		print("Player data: " + str(sw_result.player_data))

func _cloud_load_data():
	if State.user_info["signed_in"] == true:
		var sw_result = await SilentWolf.Players.get_player_data(State.user_info["username"]).sw_get_player_data_complete
		print("Player data: " + str(sw_result.player_data))
		if sw_result and sw_result.success and sw_result.player_data:
			load_data(sw_result.player_data)


func _on_button_6_pressed():
	get_tree().change_scene_to_file("res://settings.tscn")
