extends CanvasLayer

var move_id = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	$"move toast".move_id = move_id


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
