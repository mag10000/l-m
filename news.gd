extends Control

@onready var item = preload("res://news_item.tscn")
var loaded = false
var news = []

func _process(delta):
	if loaded == false:
		loaded = true
		$loading.show()
		var sw_result: Dictionary = await SilentWolf.Scores.get_scores(0,"news").sw_get_scores_complete
		news = sw_result.scores
		if news.size() != 0:
			for news_item in news:
				var instance = item.instantiate()
				instance.data = news_item["metadata"]
				$ScrollContainer/VBoxContainer.add_child(instance)
		else:
			$"ScrollContainer/VBoxContainer/no found".show()
		$loading.hide()
