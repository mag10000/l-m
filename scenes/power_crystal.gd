extends Node2D

var playing
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if State.escape == true:
		$Timer.paused = true
		$AudioStreamPlayer.stream_paused = true
	else:
		$Timer.paused = false
		$AudioStreamPlayer.stream_paused = false



func _on_area_2d_body_entered(body):
	State.powered_by_crystals = true
	$Timer.start()
	$AnimatedSprite2D.play("dying")
	$AudioStreamPlayer.play()
	$Area2D.queue_free()



func _on_timer_timeout():
	State.powered_by_crystals = false
	$AudioStreamPlayer.stop()
	self.queue_free()
