extends Node2D

var date_dict = Time.get_date_dict_from_system()  

var current_month = date_dict["month"]


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if current_month == 12:
		$GPUParticles2D.emitting = false
		$TileMap2.visible = false
	var current_day = date_dict["day"]
	if current_month == 10 && current_day == 31:
		$ColorRect.visible = true


func _on_timer_timeout():
	State.jacob_level_1_done = true
	State.save_menu_scene = ("res://scenes/cutscene_3.tscn")
	get_tree().change_scene_to_file("res://scenes/cutscene_3.tscn")
