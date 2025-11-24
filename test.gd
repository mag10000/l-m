extends Node2D

var mod_on = false

var mod_name = "testmod"

var mod_resource = ""

var switched_camera = false
# var camera_node = get_node($"main dude/Camera2D")

# Called when the node enters the scene tree for the first time.
func _ready():
	#if State.show_leaderboard_timer == true:
		State.instanciate_LeaderboardTimer()
		State.score_level = "Tutorial"
	#else:
	#	State.kill_LeaderboardTimer()
	#	State.score_level = "Tutorial"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if State.player_2_in == true:
		if switched_camera == false:
			switched_camera = true
			$"player2/Camera2D".make_current()
			
	else:
		$"main dude/Camera2D".make_current()

			
			#$"main dude".remove_child($"main dude/Camera2D")
			#$player2.add_child($"main dude/Camera2D")
			#$"player2/Camera2D".make_current()
