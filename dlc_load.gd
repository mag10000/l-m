extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print(State.dlc_on)


func load_data_tdlc (load_dict):
	if FileAccess.file_exists("user://testdlc.json"):
		if load_dict.has("code"):
			if load_dict["code"] == "123456789":
				State.dlc_on = "testdlc"
	else:
		$Label.text = "dlc not avilible"
		$Timer.start()
		print("dlc not avilible")


func _on_button_pressed():
	save_manager.path = "user://testdlc.json"
	load_data_tdlc(save_manager.read_save())
	save_manager.path = "user://lm_data.json"


func _on_timer_timeout():
	$Label.text = ""
