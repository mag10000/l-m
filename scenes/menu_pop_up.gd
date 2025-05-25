extends CanvasLayer

var main_menu_pressed = false
var co_op_snch = true

func _on_back_pressed():
	State.escape = false
	$Control/ColorRect.visible = false
	self.visible = false

func _on_quit_pressed():
	get_tree().quit()

func _process(delta):
	if State.arcade == true:
		$Control/quit.visible = false
		
	
	
	#translations
	if State.translated_to_spanish == true:
		$Control/quit.text = ("abandonar")
		$"Control/co-op".text = ("dos jugadores")
		$Control/back.text = ("atrás")
		$Control/Button.text = ("nivel de reinicio")
		$Control/hats.text = ("sombreros")
		$"Control/co-op_2".text = ("tres jugadores")
		$"Control/co-op_3".text = ("cuatro jugadores")
		$Control/map.text = ("mapa")
		$Control/main_menu.text = ("menú principal")
		$Control/VBoxContainer/ColorRect2/Label.text = ("Tu progreso en tunivel no se guardará")
		$Control/VBoxContainer/Button1.text = ("   dejar   ")
		$Control/VBoxContainer/Button2.text = ("permanecer")
	else:
		$Control/quit.text = ("quit")
		$"Control/co-op".text = ("2 players")
		$Control/back.text = ("back")
		$Control/Button.text = ("re-start level")
		$Control/hats.text = ("hats")
		$"Control/co-op_2".text = ("3 players")
		$"Control/co-op_3".text = ("4 players")
		$Control/map.text = ("map")
		$Control/main_menu.text = ("main menu")
		$Control/VBoxContainer/ColorRect2/Label.text = ("your progress on your
 level will not be saved")
		$Control/VBoxContainer/Button1.text = ("   leave   ")
		$Control/VBoxContainer/Button2.text = ("stay")		


	if State.co_op_unlocked == true:
		$"Control/co-op".disabled = false
		$"Control/co-op_2".disabled = false
		$"Control/co-op_3".disabled = false
	if State.escape == false:
		self.visible = false
		$Control/ColorRect.visible = false
	if State.escape == true:
		self.visible = true
		$Control/ColorRect.visible = true
	if main_menu_pressed == false:
		co_op_snch = State.co_op_unlocked


func _on_coop_pressed():
	State.player_2_in = !State.player_2_in
	State.player_3_in = false
	State.player_4_in = false
	State.escape = !State.escape
	$Control/ColorRect.visible = !$Control/ColorRect.visible
	self.visible = !self.visible
	State.death = false
	State.death2 = false
	State.death3 = false
	State.death4 = false
	get_tree().reload_current_scene()


func _on_button_pressed():
	State.death = false
	State.death2 = false
	State.death3 = false
	State.death4 = false
	get_tree().reload_current_scene()
	State.escape = false
	





	


func _on_coop_2_pressed():
	State.player_3_in = !State.player_3_in
	State.escape = !State.escape
	$Control/ColorRect.visible = !$Control/ColorRect.visible
	self.visible = !self.visible
	State.player_2_in = true
	State.player_4_in = false
	State.death = false
	State.death2 = false
	State.death3 = false
	State.death4 = false
	get_tree().reload_current_scene()


func _on_coop_3_pressed():
	State.player_4_in = !State.player_4_in
	State.escape = !State.escape
	$Control/ColorRect.visible = !$Control/ColorRect.visible
	self.visible = !self.visible
	State.player_2_in = true
	State.player_3_in = true
	State.death = false
	State.death2 = false
	State.death3 = false
	State.death4 = false
	get_tree().reload_current_scene()


func _on_map_pressed():
	if State.tuturiol_level_done == true:
		State.escape = false
		State.save_menu_scene = ("res://scenes/base.tscn")
		get_tree().change_scene_to_file("res://scenes/world_map.tscn")
	else:
		State.escape = false





func _on_main_menu_pressed():
	main_menu_pressed = true
	$Control/VBoxContainer.visible = true
	State.co_op_unlocked = false
	$Control/quit.disabled = true
	$"Control/co-op".disabled = true
	$Control/back.disabled = true
	$Control/Button.disabled = true
	$Control/hats.disabled = true
	$"Control/co-op_2".disabled = true
	$"Control/co-op_3".disabled = true
	$Control/map.disabled = true
	$Control/main_menu.disabled = true
	


func _on_button_2_pressed():
	main_menu_pressed = false
	$Control/VBoxContainer.visible = false
	State.co_op_unlocked = true
	$Control/quit.disabled = false
	$"Control/co-op".disabled = false
	$Control/back.disabled = false
	$Control/Button.disabled = false
	$Control/hats.disabled = true
	$"Control/co-op_2".disabled = false
	$"Control/co-op_3".disabled = false
	$Control/map.disabled = false
	$Control/main_menu.disabled = false
	State.co_op_unlocked = co_op_snch


func _on_button_1_pressed():
	main_menu_pressed = false
	$Control/VBoxContainer.visible = false
	State.co_op_unlocked = true
	$Control/quit.disabled = false
	$"Control/co-op".disabled = false
	$Control/back.disabled = false
	$Control/Button.disabled = false
	$Control/hats.disabled = true
	$"Control/co-op_2".disabled = false
	$"Control/co-op_3".disabled = false
	$Control/map.disabled = false
	$Control/main_menu.disabled = false
	State.co_op_unlocked = co_op_snch
	State.escape = false
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
