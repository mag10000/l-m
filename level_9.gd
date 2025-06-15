extends Node2D

var sposition = Vector2(0,0)
var doposfunc = false

@export var fire_sync = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if doposfunc == true:
		$"main dude".position = sposition


func _on_area_2d_body_entered(body):
	$Timer.start()
	$AnimatedSprite2D.play("enter")
	$"main dude".visible = false 
	sposition = $"main dude".position
	doposfunc = true


func _on_timer_timeout():
	get_tree().change_scene_to_file("")
