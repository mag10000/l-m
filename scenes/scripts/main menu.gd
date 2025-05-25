extends Node2D

var save_path = "user://variable.json"

@export var version = ("8.0")
var _1_prees = false

var date_dict = Time.get_date_dict_from_system()  

var current_month = date_dict["month"]

var current_day = date_dict["day"]

func _on_button_pressed():
	print("not a button not pressing problem")
	#State.save_menu_place_change_time = true
	##$Popup.visible = true
	State.player_2_in = false
	State.player_3_in = false
	get_tree().change_scene_to_file(State.save_menu_scene) 

func _on_button_2_pressed():
	get_tree().quit()


func _process(delta):
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
	if State.translated_to_spanish == true:
		$Button.position = Vector2(-71,21)
		_1_prees = true
		$Button4.text = ("translate to english")
		$Button2.text = ("abandonar")
		$Button.text = ("comenzar")
		$Button3.text = ("ajustes")
	if State.translated_to_spanish == false:
		$Button.size = Vector2(88,31)
		$Button.position = Vector2(-27,21)
		$Button2.text = ("quit")
		$Button.text = ("start")
		$Button3.text = ("settings")

#magnus

	if State.loginperson == ("none"):
		$Button7.disabled = true
		$MainMenuArt/ColorRect4.visible = false
		$AnimatedSprite2D2.play("new_animation")
		$Button6.disabled = true
		$AnimatedSprite2D.play("default")
		$MainMenuArt/ColorRect5.visible = false
	else:
		$AnimatedSprite2D2.play("default")
		$Button6.disabled = false
		$AnimatedSprite2D.play("new_animation")
	if State.loginperson == ("erica"):
		$Button7.disabled = false
		$MainMenuArt/ColorRect4.visible = true
		$MainMenuArt/ColorRect5.visible = true
	if State.loginperson == ("magnus"):
		$Button7.disabled = false


func _on_button_4_pressed():
	if _1_prees == false:
		State.translated_to_spanish = true
		$Button4.text = ("translate to english")
		_1_prees = true
	else:
		State.translated_to_spanish = false
		$Button4.text = ("traducir al español")
		_1_prees = false

func _ready():
	if State.fist_time_played == true:
		$AcceptDialog.popup()
	if OS.get_name() == "Windows":
		var user = OS.get_environment("USERNAME")
		$AcceptDialog.dialog_text = "Hello " + user +" and welcome to lm superheroes!"
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
	save_manager.write_save(save())

func _on_load_pressed():
	load_data(save_manager.read_save())
	#load_data()

func save():
	var save_dict = {
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
	"level_8_done" : State.level_8_done
}
	print (save_dict)
	return save_dict

func load_data(load_dict):
	if FileAccess.file_exists("user://lm_data.json"):
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
	else: 
		pass
	#for key in load_dict:
	#	State.key = load_dict[key]

func _on_mobile_pressed():
	State.mobile = !State.mobile
	print(State.mobile)


func _on_button_3_pressed():
	get_tree().change_scene_to_file("res://settings.tscn")


func _on_arcade_pressed():
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
	State.arcade = true
