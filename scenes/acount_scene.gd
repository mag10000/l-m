extends Node2D

var PatrickCode = ("1211")

var MagnusCode = ("v1cuppy#")

var JessicaCode = ("3690")

var Cxd = ("9999")

var EricaCode = ("magipoo")

var number1 = ("0")

var number2 = ("0")

var number3 = ("0")

var number4 = ("0")

var on_number = 1

var fullCode = ("0000")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	$TextEdit.text += ("1")

func _on_button_2_pressed():
	$TextEdit.text += ("2")

func _on_button_3_pressed():
	$TextEdit.text += ("3")

func _on_button_4_pressed():
	$TextEdit.text += ("4")

func _on_button_5_pressed():
	$TextEdit.text += ("5")

func _on_button_6_pressed():
	$TextEdit.text += ("6")

func _on_button_7_pressed():
	$TextEdit.text += ("7")

func _on_button_8_pressed():
	$TextEdit.text += ("8")

func _on_button_9_pressed():
	$TextEdit.text += ("9")

func _on_button_10_pressed():
	$TextEdit.text += ("0")


func _on_button_11_pressed():
	$TextEdit.text = ("")


func _on_button_12_pressed():
	fullCode = number1 + number2 + number3 + number4
	if $TextEdit.text == PatrickCode:
		State.loginperson = ("patrick")
		get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
	if $TextEdit.text == MagnusCode:
		State.loginperson = ("magnus")
		get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
	if $TextEdit.text == Cxd:
		State.loginperson = ("cxd")
		get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
	if $TextEdit.text == JessicaCode:
		State.loginperson = ("jessica")
		get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
	if $TextEdit.text == EricaCode:
		State.loginperson = ("erica")
		get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

func _on_button_13_pressed():
	State.loginperson = ("none")
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
