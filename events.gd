extends Control

var events = []

var time = 1

func _ready():
	pass

func load_events():
	var sw_result: Dictionary = await SilentWolf.Scores.get_scores(0,"event_board").sw_get_scores_complete
	events = sw_result.scores
	print(events)
	$Button.hide()
	for event in events:
		if event.has("metadata"):
			var metadata = event["metadata"]
			if metadata.has("type"):
				if metadata["type"] == "event":
					$Label.text = "Event found!"
					print("starts at: ",metadata["start_time"])
					print("ends at: ",metadata["end_time"])
					var format_1 = metadata["end_time"].split("T")
					var format_2 = format_1[1].split(":")
					$Label.text += "
ends at " + format_1[0] + "," +format_2[0] + ":" + format_2[1]
				else:
					#$Label.text = "No Events active"
					pass
			else:
				print("NO TYPE!")
		else:
			$Label.text = "No Events active"
	if $Label.text == "":
		$Label.text = "No Events active"


func _on_button_pressed():
	load_events()
	$Button.hide()

func _process(delta):
	time = int(Time.get_datetime_string_from_system())

func _on_button_2_pressed():
	$Panel.show()
	$Panel/LineEdit.text = Time.get_datetime_string_from_system()
	$Panel/LineEdit2.text = Time.get_datetime_string_from_system()


func _on_make_event_pressed():
	SilentWolf.Scores.save_score($Panel/LineEdit3.text, int(Time.get_datetime_string_from_system()), "event_board", {"start_time" : $Panel/LineEdit.text,"end_time" : $Panel/LineEdit2.text,"type" : "event"})
	load_events()
	$Panel.hide()
