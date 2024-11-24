extends Area2D
@onready var audio_stream_player_2d = $"../first talk/AudioStreamPlayer2D"

var firstEnter2 = false

func _on_body_entered(body):
		if firstEnter2 == false && State.tuturiol_level_done == false:
			$AudioStreamPlayer2D.play()
		firstEnter2 = true
		audio_stream_player_2d.stop()
