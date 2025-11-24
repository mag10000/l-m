extends Node2D

@onready var delay = $Delay
@export var recorded_objects : Array[Node]

var frames = 0
var recording_data = {}
var recording = false

func record():
	if !recording:
		$Delay.stop()
		return
	
	for ro in recorded_objects.size():
		if ro == 0:
			recording_data[frames] = {}
		var cur_obj = recorded_objects[ro]
		recording_data[frames][cur_obj.name] = {"position" : cur_obj.global_position}
	frames += 1
	
	$Delay.start()
	

func play():
	for f in frames:
		var tween = create_tween()
		for ro in recorded_objects:
			if f == 0:
				ro.global_position = recording_data[f][ro.name]["position"]
			else:
				tween.tween_property(ro, "global_position", recording_data[f][ro.name]["position"], 0.1)
		await get_tree().create_timer(0.1).timeout
	
	frames = 0
	recording_data = {}

func _on_delay_timeout():
	if recording:
		record()
