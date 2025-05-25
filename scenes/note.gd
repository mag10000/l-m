extends Node2D

var _1_prees = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if State.translated_to_spanish == true:
		$Button.text = ("translate to english")
		$Label.text = ("o todos mis secuaces en la base
 n.° 1 de Shadow






Sombra M y yo nos dirigimos al
mundo de los perros y vamos a
aterrorizar a los perros
a continuación iremos al mundo
de los gatos
para aterrorizar a los gatos
después de eso nos dirigiremos
a
otro mundo, no estoy seguro de 
cuál
todavía












de tu jefe Shadow L")
	else:
		$Button.text = ("traducir al español")
		$Label.text = ("to all of my minoins at shadow
 base # 1 






Me and shadow m are heading to
dog world and are going to 
terrorise the dogs 
next we are going to cat world
to terrorise the cats
after that we are heading to 
another world not sure witch
one just yet















from your boss shadow L")


func _on_button_pressed():
	if _1_prees == false:
		State.translated_to_spanish = true
		$Button.text = ("translate to english")
		_1_prees = true
	else:
		State.translated_to_spanish = false
		$Button.text = ("traducir al español")
		_1_prees = false


func _on_timer_timeout():
	State.save_menu_scene = ("res://scenes/base.tscn")
	get_tree().change_scene_to_file("res://scenes/loading_screen.tscn")
