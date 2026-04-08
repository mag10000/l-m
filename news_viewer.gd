extends Control

var body
var title

func _ready():
	body = NewsGlobal.body
	title = NewsGlobal.title
	$STUFF/Title.text = title
	
	if body == []:
		$STUFF/ArticleScroll/article/nothing.show()
	
	print("BODY ", body)
	for item in body:
		if item.contains("[text]"):
			var new_text = item.replace("[text]","")
			var label = Label.new()
			label.text = new_text
			label.add_theme_font_override("font",load("res://assets/fonts/PressStart2P-Regular.ttf"))
			label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
			label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
			label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
			$STUFF/ArticleScroll/article.add_child(label)
		if item.contains("[rich_text]"):
			var new_text = item.replace("[rich_text]","")
			var label = RichTextLabel.new()
			label.text = new_text
			label.bbcode_enabled = true
			label.add_theme_font_override("normal_font",load("res://assets/fonts/PressStart2P-Regular.ttf"))
			label.fit_content = true
			label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
			label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
			label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
			$STUFF/ArticleScroll/article.add_child(label)
		if item.contains("[img]"):
			var scene = preload("res://sign in/image_web_news.tscn")
			var image_displayer = scene.instantiate()
			if item.contains("[url]"):
				var split = item.split("[url]")
				image_displayer.url = split[1]
			else:
				image_displayer.url = "https://us.123rf.com/450wm/pavelstasevich/pavelstasevich1811/pavelstasevich181101065/112815953-no-image-available-icon-flat-vector.jpg"
			$STUFF/ArticleScroll/article.add_child(image_displayer)
		if item.contains("[web]"):
			var scene = preload("res://web_view_news.tscn")
			var web_displayer = scene.instantiate()
			if item.contains("[url]"):
				var split = item.split("[url]")
				web_displayer.url = split[1]
				if split[1].contains("["):
					var split2 = split[1].split("[")
					print(split2[0])
					web_displayer.url = str(split2[0])
				else:
					web_displayer.url = str(split[1])
			else:
				web_displayer.url = "https://wpstorelocator.co/wp-content/uploads/2016/07/settings-gmap-api-error-2.gif"
			if item.contains("[label]"):
				var split = item.split("[label]")
				web_displayer.Display = str(split[1])
				if split[1].contains("["):
					var split2 = split[1].split("[")
					print(split2[0])
					web_displayer.Display = str(split2[0])
				else:
					web_displayer.Display = str(split[1])
			else:
				web_displayer.Display = "WEB"
			$STUFF/ArticleScroll/article.add_child(web_displayer)
		if item.contains("[button]"):
			var scene = preload("res://news_button.tscn")
			var button = scene.instantiate()
			if item.contains("[label]"):
				var split = item.split("[label]")
				button.text = split[1]
				if split[1].contains("["):
					var split2 = split[1].split("[")
					print(split2[0])
					button.text = str(split2[0])
				else:
					button.text = str(split[1])
			else:
				button.text = "Click Me"
			if item.contains("[action]"):
				var split = item.split("[action]")
				if split[1].contains("["):
					var split2 = split[1].split("[")
					print(split2[0])
					button.action = str(split2[0])
				else:
					button.action = str(split[1])
			else:
				button.action = "webview"
			if item.contains("[data]"):
				var split = item.split("[data]")
				button.action_data = str(split[1])
				if split[1].contains("["):
					var split2 = split[1].split("[")
					button.action_data = str(split2[0])
				else:
					button.action_data = str(split[1])
			else:
				button.action_data = "about:blank"
			$STUFF/ArticleScroll/article.add_child(button)
