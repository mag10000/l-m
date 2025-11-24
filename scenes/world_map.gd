extends Node2D

func _ready():
	pass
	if TranslationServer.get_locale().contains("cmn"):
		$Button.add_theme_font_size_override("font_size",12)
		$tutorial.add_theme_font_size_override("font_size",12)
		$"firey the dragons house".add_theme_font_size_override("font_size",12)
		$"level 2".add_theme_font_size_override("font_size",12)
		$"source of strange signal".add_theme_font_size_override("font_size",12)
		$"level 3".add_theme_font_size_override("font_size",12)
		$level_4.add_theme_font_size_override("font_size",12)
		$level_5.add_theme_font_size_override("font_size",12)
		$"firey the dragon level 2".add_theme_font_size_override("font_size",12)
		$level_6.add_theme_font_size_override("font_size",12)
		$level_7.add_theme_font_size_override("font_size",12)
		$level_8.add_theme_font_size_override("font_size",12)
		$portal.add_theme_font_size_override("font_size",12)
	
	State.kill_LeaderboardTimer()
	State.score = 0


func _on_tutorial_pressed():
	State.save_menu_scene = ("res://scenes/world.tscn")
	get_tree().change_scene_to_file("res://scenes/world.tscn")
	State.co_op_unlocked = true

func _on_button_pressed():
	State.save_menu_scene = ("res://scenes/Level_1.tscn")
	get_tree().change_scene_to_file("res://scenes/Level_1.tscn")
	State.co_op_unlocked = true


func _on_firey_the_dragons_house_pressed ():
	if State.cutscene1_done == false:
		State.save_menu_scene = ("res://scenes/cutscene.tscn")
		get_tree().change_scene_to_file("res://scenes/cutscene.tscn")
	else:
		State.save_menu_scene = ("res://scenes/jacob_level_1.tscn")
		get_tree().change_scene_to_file("res://scenes/jacob_level_1.tscn")



func _process(_delta):
	
	#translations
	pass

#unlocking levels
	if State.level_one_done == true:
		$"firey the dragons house".disabled = false
		$"level 2".visible = true
	if State.jacob_level_1_done == true:
		$"level 2".disabled = false
		$"source of strange signal".visible = true
	if State.level_two_done == true:
		$"level 3".visible = true
		$"source of strange signal".disabled = false
		if State.translated_to_spanish == false:
			$"source of strange signal".text = tr("source of strange signal")
		if State.translated_to_spanish == false:
			pass
	if State.strange_signal_level_done == true:
		if State.arcade == true:
			State.save_menu_scene = ("res://scenes/world")
			get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
#		State.save_menu_scene = ("res://scenes/end_of_demo.tscn")
#		get_tree().change_scene_to_file("res://scenes/end_of_demo.tscn")
		$"level 3".disabled = false
		$level_4.visible = true
	if State.level_three_done == true:
		$level_4.disabled = false
		$level_5.visible = true
	if State.level_four_done == true:
		$level_5.disabled = false
		$"firey the dragon level 2".visible = true
	if State.level_five_done == true:
		$"firey the dragon level 2".disabled = false
		$level_6.visible = true
	if State.fire_2 == true:
		$level_6.disabled = false
		$level_7.visible = true
	if State.level_6_done == true:
		$level_7.disabled = false
		$level_8.visible = true
	if State.level_7_done == true:
		$level_8.disabled = false
		$portal.visible = true
	if State.level_8_done == true:
		$portal.disabled = false

func _on_level_2_pressed():
	State.save_menu_scene = ("res://scenes/level_2.tscn")
	get_tree().change_scene_to_file("res://scenes/level_2.tscn")


func _on_source_of_strange_signal_pressed():
	if State.cutscene_4 == false:
		State.save_menu_scene = ("res://scenes/strange_signal_cutscene.tscn")
		get_tree().change_scene_to_file("res://scenes/strange_signal_cutscene.tscn")
	if State.cutscene_4 == true:
		State.save_menu_scene = ("res://scenes/strange_signal_level.tscn")
		get_tree().change_scene_to_file("res://scenes/strange_signal_level.tscn")


func _on_level_3_pressed():
	State.save_menu_scene = ("res://scenes/level_3.tscn")
	get_tree().change_scene_to_file("res://scenes/level_3.tscn")




func _on_level_4_pressed():
	State.save_menu_scene = ("res://scenes/level_4.tscn")
	get_tree().change_scene_to_file("res://scenes/level_4.tscn")


func _on_button_2_pressed():
	if $Camera2D.zoom.x <= 6:
		$Camera2D.zoom.y += 1
		$Camera2D.zoom.x += 1


func _on_button_3_pressed():
	$Camera2D.zoom.y -= 1
	$Camera2D.zoom.x -= 1


func _on_level_5_pressed():
	State.save_menu_scene = ("res://scenes/level_5.tscn")
	get_tree().change_scene_to_file("res://scenes/level_5.tscn")


func _on_firey_the_dragon_level_2_pressed():
	if State.fire_2 == false:
		State.save_menu_scene = ("res://scenes/cutscene_4.tscn")
		get_tree().change_scene_to_file("res://scenes/cutscene_4.tscn")
	else:
		State.save_menu_scene = ("res://feiry_level_2.tscn")
		get_tree().change_scene_to_file("res://feiry_level_2.tscn")


func _on_level_6_pressed():
	State.save_menu_scene = ("res://scenes/level_6.tscn")
	get_tree().change_scene_to_file("res://scenes/level_6.tscn")


func _on_level_7_pressed():
	State.save_menu_scene = ("res://scenes/level_7.tscn")
	get_tree().change_scene_to_file("res://scenes/level_7.tscn")


func _on_level_8_pressed():
	State.save_menu_scene = ("res://level_8.tscn")
	get_tree().change_scene_to_file("res://level_8.tscn")


func _on_portal_pressed():
	State.save_menu_scene = ("res://level_9.tscn")
	get_tree().change_scene_to_file("res://level_9.tscn")
