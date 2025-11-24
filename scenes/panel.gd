extends Panel


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$"..".SPEED = $SpinBox.value
	$"..".JUMP_VELOCITY = $SpinBox2.value
