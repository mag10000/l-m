extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if State.player_2_in == true:
		$magnus.visible = true
		$AudioStreamPlayer2D2.volume_db = 8.647
	else:
		$magnus.visible = false
	if State.player_3_in == true:
		$AnimatedSprite2D.visible = true


func _on_timer_timeout():
	$AudioStreamPlayer2D2.volume_db = -80
	State.cutscene_5_done = true
	State.save_menu_scene = ("res://scenes/smobeybobey_fight_1.tscn")
	get_tree().change_scene_to_file("res://scenes/smobeybobey_fight_1.tscn")
	
