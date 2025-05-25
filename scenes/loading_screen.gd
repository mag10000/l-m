extends Node2D





func _on_timer_timeout():
	State.death = false
	State.death2 = false
	State.death3 = false
	State.death4 = false
	State.save_menu_scene = ("res://scenes/base.tscn")
	get_tree().change_scene_to_file("res://scenes/base.tscn")


func _process(delta):
	if State.player_2_in == true:
		$AnimatedSprite2D/AnimatedSprite2D.visible = true
	if State.player_3_in == true:
		$AnimatedSprite2D/AnimatedSprite2D/AnimatedSprite2D2.visible = false
	if State.player_4_in == true:
		$AnimatedSprite2D/AnimatedSprite2D/AnimatedSprite2D2/AnimatedSprite2D.visible = true
