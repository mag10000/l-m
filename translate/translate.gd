extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_english_pressed():
	TranslationServer.set_locale("en")


func _on_spanish_pressed():
	TranslationServer.set_locale("es")


func _on_simp_chiness_pressed():
	TranslationServer.set_locale("cmn")


func _on_close_pressed():
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")


func _on_korian_pressed():
	TranslationServer.set_locale("ko")


func _on_japaness_pressed():
	TranslationServer.set_locale("ja")


func _on_french_pressed():
	TranslationServer.set_locale("fr")


func _on_brazil_pressed():
	TranslationServer.set_locale("br")


func _on_polish_pressed():
	TranslationServer.set_locale("pl")


func _on_button_pressed():
	get_tree().change_scene_to_file("res://online/lobby_scene.tscn")


func _on_ml_pressed():
	TranslationServer.set_locale("magnuslaung")
