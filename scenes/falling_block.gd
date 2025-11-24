extends RigidBody2D

@export var speed : float = 2.00
var initail_pos : Vector2
var moving = false

# Called when the node enters the scene tree for the first time.
func _ready():
	initail_pos = position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if moving == true:
		position.y += speed


func _on_area_2d_body_entered(body):
	$Timer.start()
	moving = true


func _on_timer_timeout():
	moving = false
	rotation_degrees = 0
	position = initail_pos
