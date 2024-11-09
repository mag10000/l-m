extends Area2D

@onready var timer = $Timer
@onready var audio_stream_player_2d = $AudioStreamPlayer2D


func _on_body_entered(body):
	audio_stream_player_2d.play()
	print("you died player 2")
	Engine.time_scale = 0.5
	State.death4 = true
	timer.start()


func _on_timer_timeout():
	Engine.time_scale = 1.0
	State.death4 = false
