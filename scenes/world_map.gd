extends Node2D




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



func _process(delta):
	#translations
	if State.translated_to_spanish == true:
		$tutorial.text = ("nivel de instrucción")
		$Button.text = ("La guarida de smobeybobey")
		$"firey the dragons house".text = ("Firey la casa de los dragones")
		$"level 2".text = ("nivel dos")
		if State.level_two_done == false:
			$"source of strange signal".text = ("nivel tres")
		if State.level_two_done == true:
			$"source of strange signal".text = ("fuente de señal extraña")
		$"level 3".text = ("nivel tres")
		$level_4.text = ("nivel cuatro")
		$level_5.text = ("nivel cinco")
		$"firey the dragon level 2".text = ("firey el dragón nivel dos")
	else:
		$tutorial.text = ("tutorial")
		$Button.text = ("smobeybobey's lair")
		$"firey the dragons house".text = ("firey the dragons house")
		$"level 2".text = ("level 2")
		if State.level_two_done == false:
			$"source of strange signal".text = ("level 3")
		if State.level_two_done == true:
			$"source of strange signal".text = ("source of strange signal")
		$"level 3".text = ("level 3")
		$level_4.text = ("level 4")
		$level_5.text = ("level 5")
		$"firey the dragon level 2".text = ("firey the dragon level 2")

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
			$"source of strange signal".text = ("source of strange signal")
		if State.translated_to_spanish == false:
			pass
	if State.strange_signal_level_done == true:
		$"level 3".disabled = false
		$level_4.visible = true
	if State.level_three_done == true:
		$level_4.disabled = false
		$level_5.visible = true
	if State.level_four_done == true:
		$level_5.disabled = false
		$"firey the dragon level 2".visible = true


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
