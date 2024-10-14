extends CanvasLayer




func _on_back_pressed():
	State.escape = false
	$"../ColorRect".visible = false
	$".".visible = false

func _on_quit_pressed():
	get_tree().quit()

func _process(delta):
	if State.co_op_unlocked == true:
		$"co-op".disabled = false
		$"co-op_2".disabled = false

func _on_coop_pressed():
	State.player_2_in = !State.player_2_in
	State.player_3_in = false
	State.escape = !State.escape
	$"../ColorRect".visible = !$"../ColorRect".visible
	$".".visible = !$".".visible
	get_tree().reload_current_scene()


func _on_button_pressed():
	get_tree().reload_current_scene()
	State.escape = false





	


func _on_coop_2_pressed():
	State.player_3_in = !State.player_3_in
	State.escape = !State.escape
	$"../ColorRect".visible = !$"../ColorRect".visible
	$".".visible = !$".".visible
	State.player_2_in = true
	get_tree().reload_current_scene()
