extends Button


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_pressed():
	$"../../Camera2D".position.y -= 648


func _on_down_pressed():
	$"../../Camera2D".position.y += 648
