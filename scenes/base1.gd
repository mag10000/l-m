extends Node2D

@onready var audio_stream_player = $AudioStreamPlayer



@onready var label = $Label
@onready var button = $Button
@onready var button2 = $Button2
@onready var button3 = $Button3









func _on_button_3_pressed():
	State.save_menu_scene = ("res://scenes/world_map.tscn")
	get_tree().change_scene_to_file("res://scenes/world_map.tscn")



func _process(delta):
	if State.boss_fight_1_done == true:
		$"training center/CollisionShape2D".disabled = true
	

