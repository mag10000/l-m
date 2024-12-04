extends Node2D

var switched_camera = false
# var camera_node = get_node($"main dude/Camera2D")
@export var camera: Camera2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if State.player_2_in == true:
		if switched_camera == false:
			switched_camera = true
			$"main dude".remove_child(camera)
			$player2.add_child(camera)
			#camera.make_current()

			
			#$"main dude".remove_child($"main dude/Camera2D")
			#$player2.add_child($"main dude/Camera2D")
			#$"player2/Camera2D".make_current()
