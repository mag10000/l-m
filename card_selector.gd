extends Control


func _ready():
	$ScrollContainer/GridContainer/TextureRect/ColorRect.visible = !Cards.card_data["lucas_card"]
	$ScrollContainer/GridContainer/TextureRect/LucasButton.disabled = !Cards.card_data["lucas_card"]
	$ScrollContainer/GridContainer/TextureRect2/ColorRect.visible = !Cards.card_data["lucas_card"]
	$ScrollContainer/GridContainer/TextureRect2/MagnusButton.disabled = !Cards.card_data["lucas_card"]
	$ScrollContainer/GridContainer/TextureRect3/ColorRect.visible = !Cards.card_data["lucas_card"]
	$ScrollContainer/GridContainer/TextureRect3/ShadowLButton.disabled = !Cards.card_data["lucas_card"]
	$ScrollContainer/GridContainer/TextureRect4/ColorRect.visible = !Cards.card_data["lucas_card"]
	$ScrollContainer/GridContainer/TextureRect4/ShadowMButton.disabled = !Cards.card_data["lucas_card"]
	$ScrollContainer/GridContainer/TextureRect5/ColorRect.visible = !Cards.card_data["lucas_card"]
	$ScrollContainer/GridContainer/TextureRect5/ShadowkidButton.disabled = !Cards.card_data["lucas_card"]
	$ScrollContainer/GridContainer/TextureRect6/ColorRect.visible = !Cards.card_data["lucas_card"]
	$ScrollContainer/GridContainer/TextureRect6/SmobeyButton.disabled = !Cards.card_data["lucas_card"]
	$ScrollContainer/GridContainer/TextureRect7/ColorRect.visible = !Cards.card_data["lucas_card"]
	$ScrollContainer/GridContainer/TextureRect7/JacobButton.disabled = !Cards.card_data["lucas_card"]

func _on_lucas_button_pressed():
	Cards.current_card = "lucas"
	get_tree().change_scene_to_file("res://card_test.tscn")


func _on_magnus_button_pressed():
	Cards.current_card = "magnus"
	get_tree().change_scene_to_file("res://card_test.tscn")


func _on_shadow_l_button_pressed():
	Cards.current_card = "shadow_l"
	get_tree().change_scene_to_file("res://card_test.tscn")


func _on_shadow_m_button_pressed():
	Cards.current_card = "shadow_m"
	get_tree().change_scene_to_file("res://card_test.tscn")


func _on_shadowkid_button_pressed():
	Cards.current_card = "shadow_kid"
	get_tree().change_scene_to_file("res://card_test.tscn")


func _on_smobey_button_pressed():
	Cards.current_card = "smobeybobey"
	get_tree().change_scene_to_file("res://card_test.tscn")


func _on_jacob_button_pressed():
	Cards.current_card = "jacob"
	get_tree().change_scene_to_file("res://card_test.tscn")
