extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	State.player_2_in = true
	State.player_3_in = true
	State.player_4_in = true

func _on_area_2d_body_entered(body):
	$"main dude".position = Vector2(-39,-42)
	$player2.position = Vector2(-32,-18)
	$ian.position = Vector2(-7,-18)
	$tall_boi.position = Vector2(-91,-55)
