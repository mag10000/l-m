extends CanvasLayer

var money = (State.money)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var money = (State.money)
	$Label.text = (money)
