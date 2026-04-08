extends CanvasLayer

var main_menu_pressed = false
var co_op_snch = true

func _ready():
	if TranslationServer.get_locale().contains("cmn"):
		$Control/back.add_theme_font_size_override("font_size",24)
		$Control/quit.add_theme_font_size_override("font_size",24)
		$"Control/co-op".add_theme_font_size_override("font_size",24)
		$Control/Button.add_theme_font_size_override("font_size",24)
		$Control/hats.add_theme_font_size_override("font_size",24)
		$"Control/co-op_2".add_theme_font_size_override("font_size",24)
		$"Control/co-op_3".add_theme_font_size_override("font_size",24)
		$Control/map.add_theme_font_size_override("font_size",24)
		$Control/main_menu.add_theme_font_size_override("font_size",24)
		$Control/VBoxContainer/Button1.add_theme_font_size_override("font_size",24)
		$Control/VBoxContainer/Button2.add_theme_font_size_override("font_size",24)


func _on_back_pressed():
	State.escape = false
	$Control/ColorRect.visible = false
	self.visible = false

func _on_quit_pressed():
	save_manager.write_save(save())
	GDSync.quit()

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
	"version" : State.version,
	"card_data" : Cards.card_data,
	"show_leaderboard_timer" : State.show_leaderboard_timer
}
	print (save_dict)
	return save_dict

func _process(_delta):
	if State.arcade == true:
		$Control/quit.visible = false
		
	
	
	#translations


	if State.co_op_unlocked == true:
		$"Control/co-op".disabled = false
		$"Control/co-op_2".disabled = false
		$"Control/co-op_3".disabled = false
	if State.escape == false:
		self.visible = false
		$Control/ColorRect.visible = false
	if State.escape == true:
		self.visible = true
		$Control/ColorRect.visible = true
	if main_menu_pressed == false:
		co_op_snch = State.co_op_unlocked


func _on_coop_pressed():
	State.player_2_in = !State.player_2_in
	State.player_3_in = false
	State.player_4_in = false
	State.escape = !State.escape
	$Control/ColorRect.visible = !$Control/ColorRect.visible
	self.visible = !self.visible
	State.death = false
	State.death2 = false
	State.death3 = false
	State.death4 = false
	get_tree().reload_current_scene()


func _on_button_pressed():
	State.death = false
	State.death2 = false
	State.death3 = false
	State.death4 = false
	get_tree().reload_current_scene()
	State.escape = false
	





	


func _on_coop_2_pressed():
	State.player_3_in = !State.player_3_in
	State.escape = !State.escape
	$Control/ColorRect.visible = !$Control/ColorRect.visible
	self.visible = !self.visible
	State.player_2_in = true
	State.player_4_in = false
	State.death = false
	State.death2 = false
	State.death3 = false
	State.death4 = false
	get_tree().reload_current_scene()


func _on_coop_3_pressed():
	State.player_4_in = !State.player_4_in
	State.escape = !State.escape
	$Control/ColorRect.visible = !$Control/ColorRect.visible
	self.visible = !self.visible
	State.player_2_in = true
	State.player_3_in = true
	State.death = false
	State.death2 = false
	State.death3 = false
	State.death4 = false
	get_tree().reload_current_scene()


func _on_map_pressed():
	if State.tuturiol_level_done == true:
		State.escape = false
		State.save_menu_scene = ("res://scenes/base.tscn")
		get_tree().change_scene_to_file("res://scenes/world_map.tscn")
	else:
		State.escape = false





func _on_main_menu_pressed():
	$Control/VBoxContainer/Button1.grab_focus()
	main_menu_pressed = true
	$Control/VBoxContainer.visible = true
	State.co_op_unlocked = false
	$Control/quit.disabled = true
	$"Control/co-op".disabled = true
	$Control/back.disabled = true
	$Control/Button.disabled = true
	$Control/hats.disabled = true
	$"Control/co-op_2".disabled = true
	$"Control/co-op_3".disabled = true
	$Control/map.disabled = true
	$Control/main_menu.disabled = true
	


func _on_button_2_pressed():
	main_menu_pressed = false
	$Control/VBoxContainer.visible = false
	$Control/main_menu.grab_focus()
	State.co_op_unlocked = true
	$Control/quit.disabled = false
	$"Control/co-op".disabled = false
	$Control/back.disabled = false
	$Control/Button.disabled = false
	$Control/hats.disabled = true
	$"Control/co-op_2".disabled = false
	$"Control/co-op_3".disabled = false
	$Control/map.disabled = false
	$Control/main_menu.disabled = false
	State.co_op_unlocked = co_op_snch


func _on_button_1_pressed():
	main_menu_pressed = false
	$Control/VBoxContainer.visible = false
	State.co_op_unlocked = true
	$Control/quit.disabled = false
	$"Control/co-op".disabled = false
	$Control/back.disabled = false
	$Control/Button.disabled = false
	$Control/hats.disabled = true
	$"Control/co-op_2".disabled = false
	$"Control/co-op_3".disabled = false
	$Control/map.disabled = false
	$Control/main_menu.disabled = false
	State.co_op_unlocked = co_op_snch
	State.escape = false
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")


func _on_visibility_changed():
	$Control/back.grab_focus()
