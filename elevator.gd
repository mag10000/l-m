extends Area2D

var firstEnter = false

func _on_body_entered(body):
	if firstEnter == false && State.tuturiol_level_done == false:
		$AudioStreamPlayer2D.play()
		firstEnter = true
