extends HBoxContainer

@export var text : String
@export var id: int
var friends = []
var requests = []

# Called when the node enters the scene tree for the first time.
func _ready():
	$RichTextLabel.text = text
	retrive_friends()
	retrive_requests()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func retrive_friends():
	var sw_result: Dictionary = await SilentWolf.Scores.get_scores(0,"friends").sw_get_scores_complete
	friends = sw_result.scores
	print("friends: " + str(friends))

func retrive_requests():
	var sw_result: Dictionary = await SilentWolf.Scores.get_scores(0,"friend_requests_new").sw_get_scores_complete
	requests = sw_result.scores
	print("friends: " + str(requests))
	$Button.disabled = false


func _on_button_pressed():
	var to = ""
	for request in requests:
		var metadata = request["metadata"]
		if metadata.has("id"):
			if metadata["id"] == id:
				to = metadata["to"]
	SilentWolf.Scores.save_score("friend_request made at:" + Time.get_datetime_string_from_system(), int(Time.get_datetime_string_from_system()), "friends", {
		"friend_1" : State.user_info["username"],
		"friend_2" : to
	})
