extends Area2D

var firstEnter3 = false

func _on_body_entered(body):
		if firstEnter3 == false && State.tuturiol_level_done == false:
			$AudioStreamPlayer2D.play()
		firstEnter3 = true
