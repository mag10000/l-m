extends Node2D

@export var version = ("8.0")
var _1_prees = false


func _on_button_pressed():
	#State.save_menu_place_change_time = true
	##$Popup.visible = true
	State.player_2_in = false
	State.player_3_in = false
	get_tree().change_scene_to_file(State.save_menu_scene)

func _on_button_2_pressed():
	get_tree().quit()


func _process(delta):
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
		$Button3.text = ("sonido")
		$AudioStreamPlayer2D/Label.text = ("v veintidós puntos o")
		$AudioStreamPlayer2D/Label.position = Vector2(-45,110)
	if State.translated_to_spanish == false:
		$Button.size = Vector2(88,31)
		$Button.position = Vector2(-27,21)
		$AudioStreamPlayer2D/Label.text = (version)
		$AudioStreamPlayer2D/Label.position = Vector2(107,110)
		$Button2.text = ("quit")
		$Button.text = ("start")
		$Button3.text = ("sound")



func _on_button_4_pressed():
	if _1_prees == false:
		State.translated_to_spanish = true
		$Button4.text = ("translate to english")
		_1_prees = true
	else:
		State.translated_to_spanish = false
		$Button4.text = ("traducir al español")
		_1_prees = false




func _on_load_save_pressed():
	State.player_2_in = false
	State.player_3_in = false
	get_tree().change_scene_to_file(State.save_menu_scene)


func _on_new_save_pressed():
	State.player_2_in = false
	State.player_3_in = false
	get_tree().change_scene_to_file(State.save_menu_scene)
