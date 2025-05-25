extends Node2D

@onready var audio_stream_player = $AudioStreamPlayer

var date_dict = Time.get_date_dict_from_system()  

var current_month = date_dict["month"]

@onready var label = $Label
@onready var button = $Button
@onready var button2 = $Button2
@onready var button3 = $Button3

func _ready():
	if State.mobile == true:
		$Control/CanvasLayer.visible = true
	if State.mobile == false:
		$Control/CanvasLayer.visible = false






func _on_button_3_pressed():
	State.save_menu_scene = ("res://scenes/world_map.tscn")
	get_tree().change_scene_to_file("res://scenes/world_map.tscn")



func _process(delta):
	if current_month == 12:
		$GPUParticles2D.emitting = false
		$TileMap2.visible = false
	if State.translated_to_spanish == true:
		$Button3.text = ("mira el mapa")
	else:
		$Button3.text = ("look at map")
	

