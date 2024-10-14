extends Area2D

@onready var timer = $Timer


func _on_body_entered(body):
		timer.start()


func _on_timer_timeout():
	State.save_menu_scene = ("res://scenes/base.tscn")
	get_tree().change_scene_to_file("res://scenes/loading_screen.tscn")
	State.tuturiol_level_done = true
