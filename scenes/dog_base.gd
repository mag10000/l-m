extends Node2D

var mouse_position = get_global_mouse_position()

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
		$Button3.visible = true
		$label.visible = false
	if State.mobile == false:
		$Control/CanvasLayer.visible = false






func _on_button_3_pressed():
	State.save_menu_scene = ("res://scenes/world_map.tscn")
	get_tree().change_scene_to_file("res://scenes/world_map.tscn")



func _process(delta):
	if State.portal_done == true:
		$AnimatedSprite2D.visible = true
		$Area2D/CollisionShape2D.disabled = false
	
	
	
	if Input.is_action_just_pressed("ui_accept"):
		State.save_menu_scene = ("res://scenes/world_map_2.tscn")
		get_tree().change_scene_to_file("res://scenes/world_map_2.tscn")
	
	print(mouse_position)
	
	if current_month == 12:
		$GPUParticles2D.emitting = false
		$TileMap2.visible = false
	if State.translated_to_spanish == true:
		$Button3.text = ("Mira el mapa
con A, B o ENTER")
	else:
		$Button3.text = ("Look at Map
with A,B or ENTER")
	



func _on_area_2d_body_entered(body):
	get_tree().change_scene_to_file("res://scenes/base.tscn")
