extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if State.run_mode == true:
		$ItemList.set_item_text(0, "Run mode (On)")
	if State.run_mode == false:
		$ItemList.set_item_text(0, "Run mode (Off)")

	if State.mobile == true:
		$ItemList.set_item_text(1, "[M] Mobile (On)")
	if State.mobile == false:
		$ItemList.set_item_text(1, "[M] Mobile (Off)")

	if State.invis == true:
		$ItemList.set_item_text(2, "Invisible mode (On)")
	if State.invis == false:
		$ItemList.set_item_text(2, "Invisible mode (Off)")
		
	if State.auto_load == true:
		$ItemList.set_item_text(3, "Auto load (On)")
	if State.auto_load == false:
		$ItemList.set_item_text(3, "Auto load (Off)")
		
	if State.show_leaderboard_timer == true:
		$ItemList.set_item_text(4, "show timer (On)")
	if State.show_leaderboard_timer == false:
		$ItemList.set_item_text(4, "show timer (Off)")

func _on_item_list_item_clicked(index, at_position, mouse_button_index):
	if index == 0:
		State.run_mode = !State.run_mode
	if index == 1:
		State.mobile = !State.mobile
	if index == 2:
		State.invis = !State.invis
	if index == 3:
		State.auto_load = !State.auto_load
		print(State.auto_load)
	if index == 4:
		State.show_leaderboard_timer = !State.show_leaderboard_timer

func _on_button_pressed():
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")


func _on_button_2_pressed():
	$Button2/Label.text = OS.get_executable_path()


func _on_button_3_pressed():
	State.window_saftey = !State.window_saftey


func _on_data_migrate_pressed():
	var user = OS.get_environment("USERNAME")
	if FileAccess.file_exists("C:\\Users\\" + user + "\\AppData\\Roaming\\Godot\\app_userdata\\L M superheroes\\lm_data.json"):
		var path = "C:\\Users\\" + user + "\\AppData\\Roaming\\Godot\\app_userdata\\L M superheroes\\lm_data.json"
		$console.show()
		save_manager.path = path
		$console.text += "
		loading part 1 done"
		load_data(save_manager.read_save())


func load_data(load_dict):
	$console.text += "
	loading part 2 done"
	if FileAccess.file_exists(save_manager.path):
		$console.text += "
		file found"
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
		$console.text += "
		loading part 3 done"
				
		save_manager.path = "user://lm_data.json"
	else: 
		pass
	$console.text += "
	loading done"
	$console.text += "
	done"
	$console.text += ""
	$console.hide()



func _on_remap_pressed():
	get_tree().change_scene_to_file("res://input_settings/input_settings.tscn")
