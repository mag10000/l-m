extends Area2D

@onready var timer = $Timer
@onready var audio_stream_player_2d = $AudioStreamPlayer2D
@onready var collision_shape_2d = $"../main dude/CollisionShape2D"

func _on_body_entered(body):
	audio_stream_player_2d.play()
	print("you died")
	Engine.time_scale = 0.5
	State.death = true
	timer.start()

func _on_timer_timeout():
	Engine.time_scale = 1.0
	State.death = false
	get_tree().reload_current_scene()
