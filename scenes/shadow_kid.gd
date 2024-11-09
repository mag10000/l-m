extends Node2D

const SPEED = 60

var direction = 1

@onready var ray_cast_up = $RayCastup
@onready var ray_cast_right = $RayCastright
@onready var ray_cast_left = $RayCastleft
@onready var animated_sprite = $AnimatedSprite2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#print (Engine.time_scale)
	if ray_cast_right.is_colliding():
		direction = -1
		animated_sprite.flip_h = true
	if ray_cast_left.is_colliding():
		direction = 1
		animated_sprite.flip_h = false
	if State.powered_by_crystals == true:
		$killzone2/CollisionShape2D.disabled = true
		$killzone/CollisionShape2D.disabled = true
		$killzone3/CollisionShape2D.disabled = true
		$killzone4/CollisionShape2D.disabled = true
	if State.powered_by_crystals == false:
		$killzone2/CollisionShape2D.disabled = false
		$killzone/CollisionShape2D.disabled = false
		$killzone3/CollisionShape2D.disabled = false
		$killzone4/CollisionShape2D.disabled = false
	position.x += direction * SPEED * delta
	print ($killzone2/Timer.time_left)

func _on_area_2d_body_entered(body):
	print("Area_2d")
	Engine.time_scale = 1.0
	$AudioStreamPlayer2D.play()
	$killzone.queue_free()
	queue_free()
