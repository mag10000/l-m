extends Control

var reset = false

@onready var input_button_scene = preload("res://input_settings/input_button.tscn")
@onready var action_list = $PanelContainer/MarginContainer/VBoxContainer/ScrollContainer/ActionList


var is_remaping = false
var action_to_remap = null
var remaping_button = null




func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://settings.tscn")


func _on_reset_button_pressed():
	print("actions before reset
: ", State.input_map," 
")
	reset = true
	await get_tree().create_timer(0.01).timeout
	reset = false
