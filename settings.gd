extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if State.run_mode == true:
		$ItemList.set_item_text(0, "Run mode (On)")
	if State.run_mode == false:
		$ItemList.set_item_text(0, "Run mode (Off)")

	if State.mobile == true:
		$ItemList.set_item_text(1, "[M] Mobile (On)")
	if State.mobile == false:
		$ItemList.set_item_text(1, "[M] Mobile (Off)")

	if State.invis == true:
		$ItemList.set_item_text(2, "Invisible mode (On)")
	if State.invis == false:
		$ItemList.set_item_text(2, "Invisible mode (Off)")

func _on_item_list_item_clicked(index, at_position, mouse_button_index):
	if index == 0:
		State.run_mode = !State.run_mode
	if index == 1:
		State.mobile = !State.mobile
	if index == 2:
		State.invis = !State.invis

func _on_button_pressed():
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")


func _on_button_2_pressed():
	$Button2/Label.text = OS.get_executable_path()
