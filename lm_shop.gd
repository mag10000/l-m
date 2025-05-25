extends Node2D

var lmcoins = str(State.lmcoins)

var currrent_pack = ""


# Called when the node enters the scene tree for the first time.
func _ready():
	$CanvasLayer/Control/ColorPicker.color = State.shop_color
	$CanvasLayer/Control/ColorPicker.visible = true
	$"Control/VBoxContainer/animals mod/TextureRect".texture = load("res://mods/animal skins/logo.png")
	$"Control/VBoxContainer/purple skins/TextureRect".texture = load("res://mods/purple skins/logo.png")
	var file = FileAccess.open("res://mods/purple skins/name.txt", FileAccess.READ)
	$"Control/VBoxContainer/purple skins/Label".text = file.get_as_text()
	if State.purple_pack_bought == true:
		$"Control/VBoxContainer/purple skins/Button".text = ("eqiup")
		$"Control/VBoxContainer/purple skins/Button".icon = load("")
	file = FileAccess.open("res://mods/animal skins/name.txt", FileAccess.READ)
	$"Control/VBoxContainer/animals mod/Label2".text = file.get_as_text()
	if State.animal_pack_bought == true:
		$"Control/VBoxContainer/animals mod/Button2".text = ("eqiup")
		$"Control/VBoxContainer/animals mod/Button2".icon = load("")
 
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	lmcoins = str(State.lmcoins)
	$ColorRect.color = $CanvasLayer/Control/ColorPicker.color
	$CanvasLayer/Control/Label2.text = lmcoins


func _unhandled_input(event):
	if Input.is_action_just_pressed("scroolup"):
		$Camera2D.position.y += 5
	if Input.is_action_just_pressed("scrooldown"):
		$Camera2D.position.y -= 5





func _on_back_pressed():
	State.shop_color = $CanvasLayer/Control/ColorPicker.color
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")


func _on_button_pressed():
	if State.lmcoins >= 29:
		State.animal_pack_bought = true
		State.lmcoins -= 30
		$"Control/VBoxContainer/purple skins/Button".icon = load("")
		$"Control/VBoxContainer/purple skins/Label2".text = "on"
		$"Control/VBoxContainer/purple skins/Button".text = ("eqiup")
		State.mod = ("purple skins")
	if State.animal_pack_bought == true:
		$"Control/VBoxContainer/purple skins/Button".icon = load("")
		$"Control/VBoxContainer/purple skins/Label2".text = "on"
		$"Control/VBoxContainer/purple skins/Button".text = ("eqiup")
		State.mod = ("purple skins")

func _on_equip_pressed():
	print("it works")
	var equip = 1
	if equip == 1:
		State.mod = ("purple skins")
		print("it works")
		equip = 2
	if equip == 2:
		State.mod = ("default")
		equip = 1


func _on_unequip_pressed():
	$"Control/VBoxContainer/animals mod/Label3".text = "off"
	$"Control/VBoxContainer/purple skins/Label2".text = "off"
	State.mod = ("default")


func _on_button_2_pressed():
	if State.lmcoins >= 29:
		State.purple_pack_bought = true
		State.lmcoins -= 30
		$"Control/VBoxContainer/animals mod/Button2".icon = load("")
		$"Control/VBoxContainer/animals mod/Label3".text = "on"
		$"Control/VBoxContainer/animals mod/Button2".text = ("eqiup")
		State.mod = ("animal skins")
	if State.purple_pack_bought == true:
		$"Control/VBoxContainer/animals mod/Button2".icon = load("")
		$"Control/VBoxContainer/animals mod/Label3".text = "on"
		$"Control/VBoxContainer/animals mod/Button2".text = ("eqiup")
		State.mod = ("animal skins")
