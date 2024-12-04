extends Node2D

var _1n = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $Camera2D.position == Vector2(0, 1523):
		if _1n == false:
			$Timer.start()
			_1n = true
		pass
	else:
		$Camera2D.position.y += 0.5
	print($Camera2D.position)


func _on_timer_timeout():
	State.save_menu_scene = ("res://scenes/world.tscn")
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
