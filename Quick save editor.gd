extends Node2D

var save_menu_scene = ""

var level_one_done = false

var cutscene1_done = false

var tuturiol_level_done = false

var jacob_level_1_done = false

var boss_fight_1_done = false

var level_two_done = false

var cutscene_4 = false

var cutscene_5_done = false

var strange_signal_level_done = false

var level_three_done = false

var level_four_done = false

var level_five_done = false

var level_6_done = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	save_menu_scene = $VBoxContainer/Label/TextEdit.text
	if save_menu_scene == "":
		save_menu_scene = "res://scenes/world.tscn"

func save():
	var save_dict = {
	"save_menu_scene" : save_menu_scene, 
	"level_one_done" : level_one_done, 
	"cutscene1_done" : cutscene1_done, 
	"tuturiol_level_done" : tuturiol_level_done, 
	"jacob_level_1_done" : jacob_level_1_done, 
	"boss_fight_1_done" : boss_fight_1_done, 
	"level_two_done" : level_two_done, 
	"cutscene_4" : cutscene_4, 
	"cutscene_5_done" : cutscene_5_done, 
	"strange_signal_level_done" : strange_signal_level_done, 
	"level_three_done" : level_three_done, 
	"level_four_done" : level_four_done, 
	"level_five_done" : level_five_done, 
	"level_6_done" : level_6_done 
}
	print (save_dict)
	return save_dict


#check boxes below

func _on_check_box_pressed():
	level_one_done = !level_one_done


func _on_check_box_2_pressed():
	cutscene1_done = !cutscene1_done


func _on_check_box_3_pressed():
	tuturiol_level_done = !tuturiol_level_done


func _on_check_box_4_pressed():
	jacob_level_1_done = !jacob_level_1_done


func _on_check_box_5_pressed():
	boss_fight_1_done = !boss_fight_1_done


func _on_check_box_6_pressed():
	level_two_done = !level_two_done


func _on_check_box_7_pressed():
	cutscene_4 = !cutscene_4


func _on_check_box_8_pressed():
	cutscene_5_done = !cutscene_5_done


func _on_check_box_9_pressed():
	strange_signal_level_done = !strange_signal_level_done


func _on_check_box_10_pressed():
	level_three_done = !level_three_done


func _on_check_box_11_pressed():
	level_four_done = !level_four_done


func _on_check_box_12_pressed():
	level_five_done = !level_five_done


func _on_check_box_13_pressed():
	level_6_done = !level_6_done



func _on_button_pressed():
	save_manager.write_save(save())
