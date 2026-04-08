extends Control

var url = ""


func _on_update_img_pressed():
	url = $"Panel/Image Web/LineEdit".text
	$"Panel/Image Web".url = url
	$"Panel/Image Web".download_image()


func _on_create_pressed():
	var NEW_body = $LineEdit.text.split(",")
	print(NEW_body)
	SilentWolf.Scores.save_score($Panel/Title.text, int(Time.get_datetime_string_from_system()), "news", {"title" : $Panel/Title.text, "preview" : $Panel/Preview.text,"img_url" : $"Panel/Image Web".url,"body" : NEW_body})
