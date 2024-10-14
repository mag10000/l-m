extends Node2D




func _on_button_pressed():
	get_tree().quit


func _on_button_2_pressed():
	State.save_menu_scene = ("res://scenes/base.tscn")
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
