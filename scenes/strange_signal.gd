extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if State.player_2_in == true:
		$magnus.visible = true
		$sus_magnus.volume_db = 6.42
		$sus_lucas.volume_db = -80
	else:
		$magnus.visible = false
		$sus_lucas.volume_db = 0
	
	if State.player_3_in == true:
		$AnimatedSprite2D2.visible = true
		$sus_magnus.volume_db = 6.42
		$sus_lucas.volume_db = -80
	else:
		$AnimatedSprite2D2.visible = false
	

func _on_timer_timeout():
	State.cutscene_4 = true
	$sus_magnus.volume_db = -80
	$sus_lucas.volume_db = 0
	State.save_menu_scene = ("res://scenes/strange_signal_level.tscn")
	get_tree().change_scene_to_file("res://scenes/strange_signal_level.tscn")
