extends Button

enum Devices {
	PS3,
	STEAM,
	SWITCH,
	XBOX360,
	STEAM_DECK
}

var can_be_remapped = false
@export var action : String
@export var action_display_name : String
enum Players {
	player_1,
	player_2,
	player_3,
	player_4,
}
@export var player : Players

# Called when the node enters the scene tree for the first time.
func _ready():
	input_ready()
	var texture = $MarginContainer/HBoxContainer/TextureRect.texture
	texture.path = action
	var texture2 = $MarginContainer/HBoxContainer/TextureRect/TextureRect.texture
	texture2.path = action
	print("Joypad numb: ",ControllerIcons.get_joypad_type(player_to_int(player)))
func input_ready():
	$MarginContainer/HBoxContainer/LabelAction.text = action_display_name
	var events = InputMap.action_get_events(action)
	if not events[0].as_text().contains("Joypad"):
		$MarginContainer/HBoxContainer/LabelInput.text = str(events[0].as_text())
	else:
		var joypad = numb_to_joypad(ControllerIcons.get_joypad_type(player_to_int(player)))
		print("Joypad is:", joypad)
		var FULL = events[0].as_text()
		var split = events[0].as_text().split(joypad)
		var split2 = split[0].split(",")
		if split.size() == 2:
			split2 = split[1].split(",")
		var split3 = split2[0].split(")")
		var final = joypad_to_name(joypad) + split3[0]
		
		$MarginContainer/HBoxContainer/LabelInput.text = str(final)
		if $MarginContainer/HBoxContainer/LabelInput.text.contains("D-pad"):
			var splitpad = final.split("D-pad")
			var final_pad = "D-pad" + splitpad[1]
			$MarginContainer/HBoxContainer/LabelInput.text = final_pad
		$MarginContainer/HBoxContainer/LabelInput.text = $MarginContainer/HBoxContainer/LabelInput.text.replace("SwitchJoypad Button 9 (Left Shoulder","Switch L")
		$MarginContainer/HBoxContainer/LabelInput.text = $MarginContainer/HBoxContainer/LabelInput.text.replace("SwitchJoypad Button 10 (Right Shoulder","Switch R")
		$MarginContainer/HBoxContainer/LabelInput.text = $MarginContainer/HBoxContainer/LabelInput.text.replace("SwitchJoypad Motion on Axis 4 (Joystick 2 X-Axis","Switch ZL")
		$MarginContainer/HBoxContainer/LabelInput.text = $MarginContainer/HBoxContainer/LabelInput.text.replace("SwitchJoypad Motion on Axis 5 (Joystick 2 Y-Axis","Switch ZR")
		$MarginContainer/HBoxContainer/LabelInput.text = $MarginContainer/HBoxContainer/LabelInput.text.replace("PlaystationJoypad Button 6 (Start","Playstation Start")
		if FULL.contains("Joypad Motion on Axis 0 (Left Stick X-Axis, Joystick 0 X-Axis)"):
			$MarginContainer/HBoxContainer/LabelInput.text = "Gamepad Left Stick Input"
		if FULL.contains("Joypad Motion on Axis 2 (Right Stick X-Axis, Joystick 1 X-Axis)"):
			$MarginContainer/HBoxContainer/LabelInput.text = "Gamepad Right Stick Input"
		#Joypad Motion on Axis 0 (Left Stick X-Axis, Joystick 0 X-Axis) with Value -1.00
		print("inputNAME:",$MarginContainer/HBoxContainer/LabelInput.text)
		print("inputFULL:",FULL)
	var texture = $MarginContainer/HBoxContainer/TextureRect.texture
	texture.path = action
	var texture2 = $MarginContainer/HBoxContainer/TextureRect/TextureRect.texture
	texture2.path = action

var first = true
func _on_pressed():
	can_be_remapped = true
	$MarginContainer/HBoxContainer/LabelInput.text = "Press Key To Remap..."

func _input(event):
	if can_be_remapped:
		if (
			event is InputEventKey ||
			(event is InputEventJoypadButton ||
			(event is InputEventJoypadMotion)
			)
		):
			if event is InputEventMouseButton && event.double_click:
				event.double_click = false
			print(event)
			can_be_remapped = false
			InputMap.action_erase_events(action)
			InputMap.action_add_event(action,event)
			State.input_map[action] = event
			input_ready()

func numb_to_joypad(number : int):
	match number:
		0:
			return "Sony"
		1:
			return "Xbox"
		2:
			return "Nintendo"
		3:
			return "Xbox"
		4:
			return "Xbox"

func joypad_to_name(_name : String):
	match _name:
		"Sony":
			return "Playstation"
		"Nintendo":
			return "Switch"
		"Xbox":
			return "Xbox"

func _process(delta):
	if $"../../../../../..":
		if $"../../../../../..".reset == true:
			InputMap.load_from_project_settings()
			input_ready()

func player_to_int(player: Players):
	if player == Players.player_1:
		return 0
	if player == Players.player_2:
		return 1
	if player == Players.player_3:
		return 2
	if player == Players.player_4:
		return 3
