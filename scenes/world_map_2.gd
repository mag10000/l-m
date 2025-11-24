extends Node2D







func _process(delta):
	
	#translations
	if State.translated_to_spanish == true:
		$"level 1".text = ("Nivel 1")
	else:
		$"level 1".text = ("Level 1")

#unlocking levels
	if State.level_one_done == true:
		# make next level undisabled
		# make 2 levels forward visible
		pass
	if State.jacob_level_1_done == true:
		# make next level undisabled
		# make 2 levels forward visible
		pass


func _on_button_2_pressed():
	if $Camera2D.zoom.x <= 6:
		$Camera2D.zoom.y += 1
		$Camera2D.zoom.x += 1


func _on_button_3_pressed():
	$Camera2D.zoom.y -= 1
	$Camera2D.zoom.x -= 1


func _on_level_1_pressed():
	State.save_menu_scene = ("res://level_1_world_2.tscn")
	get_tree().change_scene_to_file("res://level_1_world_2.tscn")
