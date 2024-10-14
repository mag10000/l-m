extends Node2D





func _on_timer_timeout():
	State.save_menu_scene = ("res://scenes/base.tscn")
	get_tree().change_scene_to_file("res://scenes/base.tscn")


func _process(delta):
	if State.player_2_in == true:
		$AnimatedSprite2D/AnimatedSprite2D.visible = true
	else:
		$AnimatedSprite2D/AnimatedSprite2D.visible = false
