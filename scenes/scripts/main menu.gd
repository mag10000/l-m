extends Node2D

@export var version = ("8.0")



func _on_button_pressed():
	#State.save_menu_place_change_time = true
	State.player_2_in = false
	State.player_3_in = false
	get_tree().change_scene_to_file(State.save_menu_scene)


func _on_button_2_pressed():
	get_tree().quit()


func _process(delta):
	$Label.text = (version)

