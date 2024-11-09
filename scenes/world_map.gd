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
	if State.level_one_done == true:
		$"firey the dragons house".disabled = false
		$"level 2".visible = true
	if State.jacob_level_1_done == true:
		$"level 2".disabled = false
		$"source of strange signal".visible = true
	if State.level_two_done == true:
		$"level 3".visible = true
		$"source of strange signal".disabled = false
		$"source of strange signal".text = ("source of strange signal")
	if State.strange_signal_level_done == true:
		$"level 3".disabled = false
		$level_4.visible = true
	if State.level_three_done == true:
		$"level 4".disabled = false
		$level_5.visible = true
	if State.level_four_done == true:
		$level_5.disabled = false


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
