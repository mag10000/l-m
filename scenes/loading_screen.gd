extends Node2D

func _ready():
	save_manager.write_save(save())

func save():
	var save_dict = {
	"animal_pack_bought" : State.animal_pack_bought, 
	"save_menu_scene" : State.save_menu_scene, 
	"purple_pack_bought" : State.purple_pack_bought, 
	"mod" : State.mod, 
	"lmcoins" : State.lmcoins, 
	"shop_color" : State.shop_color,
	"fist_time_played" : State.fist_time_played,
	"co_op_unlocked" : State.co_op_unlocked, 
	"money" : State.money, 
	"on_a_jacoblevel" : State.on_a_jacoblevel, 
	"level_one_done" : State.level_one_done, 
	"cutscene1_done" : State.cutscene1_done, 
	"tuturiol_level_done" : State.tuturiol_level_done, 
	"jacob_level_1_done" : State.jacob_level_1_done, 
	"boss_fight_1_done" : State.boss_fight_1_done, 
	"level_two_done" : State.level_two_done, 
	"cutscene_4" : State.cutscene_4, 
	"cutscene_5_done" : State.cutscene_5_done, 
	"strange_signal_level_done" : State.strange_signal_level_done, 
	"level_three_done" : State.level_three_done, 
	"level_four_done" : State.level_four_done, 
	"level_five_done" : State.level_five_done, 
	"level_6_done" : State.level_6_done ,
	"level_7_done" : State.level_7_done,
	"level_8_done" : State.level_8_done
}
	print (save_dict)
	return save_dict



func _on_timer_timeout():
	State.death = false
	State.death2 = false
	State.death3 = false
	State.death4 = false
	State.save_menu_scene = ("res://scenes/base.tscn")
	get_tree().change_scene_to_file("res://scenes/base.tscn")


func _process(delta):
	if State.player_2_in == true:
		$AnimatedSprite2D/AnimatedSprite2D.visible = true
	if State.player_3_in == true:
		$AnimatedSprite2D/AnimatedSprite2D/AnimatedSprite2D2.visible = false
	if State.player_4_in == true:
		$AnimatedSprite2D/AnimatedSprite2D/AnimatedSprite2D2/AnimatedSprite2D.visible = true
