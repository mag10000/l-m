extends Node2D



# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func _on_link_button_pressed():
	$Timer.start()


func _on_timer_timeout():
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")



func get_shop_items():
	var sw_result: Dictionary = await SilentWolf.Scores.get_scores(0).sw_get_scores_complete
	var scores = sw_result.scores
	return scores
