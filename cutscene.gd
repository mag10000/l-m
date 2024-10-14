extends Node2D

func _process(delta):
	if State.player_2_in == true:
		$magnus.visible = true
		$AudioStreamPlayer2D.volume_db = -80
		$AudioStreamPlayer2D3.volume_db = 10.272
	else:
		$magnus.visible = false
	if State.player_3_in == true:
		$AnimatedSprite2D2.visible = true
		$AudioStreamPlayer2D3.volume_db = 10.272
	else:
		$AnimatedSprite2D2.visible = false

func _on_timer_timeout():
	State.cutscene1_done = true
	$AudioStreamPlayer2D.volume_db = -8.593
	$AudioStreamPlayer2D3.volume_db = -80
	State.save_menu_scene = ("res://scenes/jacob_level_1.tscn")
	get_tree().change_scene_to_file("res://scenes/jacob_level_1.tscn")
	
