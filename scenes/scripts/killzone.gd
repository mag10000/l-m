extends Area2D

@export var randomStrength: float = 30.0
@export var shakeFade: float = 5.0
@onready var timer = $Timer
@onready var audio_stream_player_2d = $AudioStreamPlayer2D
@onready var collision_shape_2d = $"../main dude/CollisionShape2D"
@export var shadow_kid = false
var camera


var rng = RandomNumberGenerator.new()

var shake_strength: float = 0.0
func _on_body_entered(body):
	camera = get_viewport().get_camera_2d()
	shake_camera(camera)
	if shadow_kid == true:
		$"../Area2D".queue_free()
	audio_stream_player_2d.play()
	print("you died")
	Engine.time_scale = 0.5
	State.death = true
	
	timer.start()

func _on_timer_timeout():
	State.powered_by_crystals = false
	Engine.time_scale = 1.0
	if State.player_2_in == false:
		State.death = false
		get_tree().reload_current_scene()

func _process(delta):
	if shake_strength > 0:
		shake_strength = lerpf(shake_strength,0,shakeFade * delta)
		
		camera.offset = randomOffset()



func shake_camera(_camera):
	shake_strength = randomStrength

func randomOffset() -> Vector2:
	return Vector2(rng.randf_range(-shake_strength,shake_strength),rng.randf_range(-shake_strength,shake_strength))
