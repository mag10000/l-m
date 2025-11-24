class_name LeaderboardTimer

extends CanvasLayer

@export var time = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _finish():
	State.score = time

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var text = ""
	var seconds = int(time) % 60
	var minutes = int(time) / 60
	var millaseconds = time - int(time)
	var millaseconds_round = _round(millaseconds,2)
	var millaseconds_format_1 = str(millaseconds_round * 10)
	var millaseconds_format_2 = millaseconds_format_1.split(".")
	var millaseconds_final = millaseconds_format_2[0] + millaseconds_format_2[1]
	print(str(seconds) + " seconds and " + str(minutes) + " minutes and " + str(millaseconds_round) + " decimal")
	$Control/Label.text = (str(minutes) + ":" + str(int(seconds)) + ":" + str(millaseconds_final))
func _round(num,places):
	return (round(num*pow(10,places))/pow(10,places))

func _on_timer_timeout():
	time += 0.01
