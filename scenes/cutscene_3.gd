extends Node2D

var date_dict = Time.get_date_dict_from_system()  

var current_month = date_dict["month"]

func _process(delta):
	if State.player_2_in == true:
		$magnus.visible = true
	else:
		$magnus.visible = false
	if State.player_3_in == true:
		$AnimatedSprite2D2.visible = true
	else:
		$AnimatedSprite2D2.visible = false
	if current_month == 12:
		$GPUParticles2D.emitting = false
		$TileMap2.visible = false
	var current_day = date_dict["day"]
	if current_month == 10 && current_day == 31:
		$ColorRect.visible = true

func _on_timer_timeout():
	State.save_menu_scene = ("res://scenes/base.tscn")
	get_tree().change_scene_to_file("res://scenes/loading_screen.tscn")
