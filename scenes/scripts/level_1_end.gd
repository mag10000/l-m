extends Area2D


func _on_body_entered(body):
	State.save_menu_scene = ("res://scenes/level_2_2.tscn")
	get_tree().change_scene_to_file("res://scenes/level_2_2.tscn")
