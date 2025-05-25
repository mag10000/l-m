extends Area2D

@onready var timer = $Timer
@onready var audio_stream_player_2d = $AudioStreamPlayer2D
@onready var collision_shape_2d = $"../main dude/CollisionShape2D"
@export var shadow_kid = false

func _on_body_entered(body):
	if shadow_kid == true:
		$"../Area2D".queue_free()
	audio_stream_player_2d.play()
	print("you died")
	Engine.time_scale = 0.5
	State.death = true
	if State.player_2_in == false:
		State.death = false
		$"../main dude".position = Vector2(40, -68)
	timer.start()

func _on_timer_timeout():
	State.powered_by_crystals = false
	Engine.time_scale = 1.0
	#if State.player_2_in == false:
	#	State.death = false
	#	$"../main dude".position = Vector2(40, -68)
