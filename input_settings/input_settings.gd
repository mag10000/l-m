extends Control


@onready var input_button_scene = preload("res://input_settings/input_button.tscn")
@onready var action_list = $PanelContainer/MarginContainer/VBoxContainer/ScrollContainer/ActionList


var is_remaping = false
var action_to_remap = null
var remaping_button = null


func _ready():
	_create_action_list()


func _create_action_list():
	InputMap.load_from_project_settings()
	for item in action_list.get_children():
		item.queue_free()
	
	for action in InputMap.get_actions():
		var button = input_button_scene.instantiate()
		var action_label = button.find_child("LabelAction")
		var input_label = button.find_child("LabelInput")
		
		if action.contains("_"):
			var text_display_dict = action.split("_")
			var text_to_display = text_display_dict[0] + " " + text_display_dict[1]
			action_label.text = text_to_display
		else:
			action_label.text = action
		
		var events = InputMap.action_get_events(action)
		if events.size() > 0:
			print(events)
			input_label.text = events[0].as_text().trim_suffix(" (Physical)")
		else:
			input_label.text = ""
		
		if not action.contains("ui"):
			action_list.add_child(button)
		button.pressed.connect(_on_input_button_pressed.bind(button,action))




func _on_input_button_pressed(button, action):
	if  !is_remaping:
		is_remaping = true
		action_to_remap = action
		remaping_button = button
		button.find_child("LabelInput").text = "Press Key To Bind....."


func _input(event):
	if is_remaping:
		if (
			event is InputEventKey ||
			(event is InputEventMouseButton ||
			(event is InputEventJoypadButton ||
			(event is InputEventJoypadMotion)
			)
			)
		):
			
			if event is InputEventMouseButton && event.double_click:
				event.double_click = false
			
			InputMap.action_erase_events(action_to_remap)
			InputMap.action_add_event(action_to_remap, event)
			_update_action_list(remaping_button, event)
			
			is_remaping = false
			action_to_remap = null
			remaping_button = null
			
			
			accept_event()
			_save()

func _update_action_list(button, event):
	button.find_child("LabelInput").text = event.as_text().trim_suffix(" (Physical)")


func _on_reset_button_pressed():
	_create_action_list()


func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://settings.tscn")


func _save():
	print("saveing")
	State.input_map["dash"] = InputMap.action_get_events("dash")
	State.input_map["drone"] = InputMap.action_get_events("drone")
	State.input_map["escape"] = InputMap.action_get_events("escape")
	State.input_map["jump"] = InputMap.action_get_events("jump")
	State.input_map["jump_2"] = InputMap.action_get_events("jump_2")
	State.input_map["jump_3"] = InputMap.action_get_events("jump_3")
	State.input_map["jump_4"] = InputMap.action_get_events("jump_4")
	State.input_map["left_3"] = InputMap.action_get_events("left_3")
	State.input_map["left_4"] = InputMap.action_get_events("left_4")
	State.input_map["right_3"] = InputMap.action_get_events("right_3")
	State.input_map["right_4"] = InputMap.action_get_events("right_4")
	State.input_map["screenshot"] = InputMap.action_get_events("screenshot")
	State.input_map["scrooldown"] = InputMap.action_get_events("scrooldown")
	State.input_map["scroolup"] = InputMap.action_get_events("scroolup")
	State.input_map["talk"] = InputMap.action_get_events("talk")
	State.input_map["walk_down"] = InputMap.action_get_events("walk_down")
	State.input_map["walk_left"] = InputMap.action_get_events("walk_left")
	State.input_map["walk_left_2"] = InputMap.action_get_events("walk_left_2")
	State.input_map["walk_right"] = InputMap.action_get_events("walk_right")
	State.input_map["walk_right_2"] = InputMap.action_get_events("walk_right_2")
	State.input_map["walk_up"] = InputMap.action_get_events("walk_up")
	print(State.input_map)
	#_load_keybinds()

func _load_keybinds():
	InputMap.action_erase_events("dash")
	InputMap.action_add_event("dash",State.load_dict["dash"])
