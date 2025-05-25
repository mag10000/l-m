extends Button





func _on_pressed():
	State.player_3_in = !State.player_3_in
	State.player_4_in = !State.player_4_in
	State.player_2_in = !State.player_2_in
	
