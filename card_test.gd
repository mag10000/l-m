extends Node3D

var rot = "<"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
	if Cards.current_card == "lucas":
			$cards/card.mesh = load("res://assets/cards/card_no_1.tres")
	if Cards.current_card == "magnus":
			$cards/card.mesh = load("res://assets/cards/card_no_2.tres")
	if Cards.current_card == "shadow_l":
			$cards/card.mesh = load("res://assets/cards/card_no_3.tres")
	if Cards.current_card == "shadow_m":
			$cards/card.mesh = load("res://assets/cards/card_no_4.tres")
	if Cards.current_card == "shadow_kid":
			$cards/card.mesh = load("res://assets/cards/card_no_5.tres")
	if Cards.current_card == "smobeybobey":
			$cards/card.mesh = load("res://assets/cards/card_no_6.tres")
	if Cards.current_card == "jacob":
			$cards/card.mesh = load("res://assets/cards/card_no_7.tres")


func _on_button_pressed():
	get_tree().change_scene_to_file("res://card_selector.tscn")
