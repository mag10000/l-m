extends Node2D


func _process(delta):
	if State.player_2_in == true:
		$magnus.visible = true
	else:
		$magnus.visible = false
	if State.player_3_in == true:
		$AnimatedSprite2D2.visible = true
	else:
		$AnimatedSprite2D2.visible = false


func _on_timer_timeout():
	State.save_menu_scene = ("res://scenes/base.tscn")
	get_tree().change_scene_to_file("res://scenes/loading_screen.tscn")
