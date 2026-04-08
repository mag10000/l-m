extends Control

var player_data = {}

func _ready():
	pass

func load_chat():
	var sw_result: Dictionary = await SilentWolf.Scores.get_scores(0,"chat").sw_get_scores_complete
	var messages = sw_result.scores

	for child in $chat/VBoxContainer.get_children():
		child.queue_free()

	for message in messages:
		if message.has("display_name"):
			var label = RichTextLabel.new()
			var hsep = HSeparator.new()
			label.meta_clicked.connect(_meta_clicked)
			label.bbcode_enabled = true
			label.custom_minimum_size.y = 50
			var metadata = message["metadata"]
			if metadata.has("from"):
				if metadata["from"] == player_data["display_name"]:
					label.text = "from: " + metadata["from"] + "(you)
	"
				else:
					label.text = "from: " + metadata["from"] + "
"
			label.add_theme_font_override("normal_font",load("res://assets/fonts/PressStart2P-Regular.ttf"))
			label.text += format_text(message["player_name"])
			label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
			$chat/VBoxContainer.add_child(label)
			$chat/VBoxContainer.add_child(hsep)



func start_chat(data):
	player_data = data
	show()
	var numb = 1
	for child in $ScrollContainer/VBoxContainer.get_children():
		if numb != 1:
			child.queue_free()
		numb += 1
	if $"..".scores:
		for score in $"..".scores:
			var label = Label.new()
			if score["player_name"] == data["display_name"]:
				label.text = score["player_name"] + "(you)"
			else:
				label.text = score["player_name"]
			label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
			label.add_theme_font_override("font",load("res://assets/fonts/PressStart2P-Regular.ttf"))
			$ScrollContainer/VBoxContainer.add_child(label)
	$Timer.start()
	load_chat()


func _on_timer_timeout():
	load_chat()


func _on_button_pressed():
	SilentWolf.Scores.save_score($LineEdit.text, int(Time.get_datetime_string_from_system()), "chat", {"from" : player_data["display_name"]})

func _meta_clicked(meta):
	OS.shell_open(str(meta))

func format_text(text : String):
	var final_text = text
	if text.contains("https://"):
		print("has \"https://\"")
		var splitted_1_text = text.split("https://")
		var splitted_2_text = splitted_1_text[1].split(" ")
		var https = "https://" + splitted_2_text[0]
		var finaler_text = final_text.replace(https,"[url=" + https + "]" + https  + "[/url]")
		final_text = finaler_text
		print("final text:" + final_text)
	return final_text
