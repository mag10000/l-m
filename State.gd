extends Node

@onready var leaderboard_timer = preload("res://leaderboard_timer.tscn")
@onready var replayer = preload("res://replay_recorder.tscn")

var current_scene

var timer_instance = null

var window_saftey = true

var portal_done = false

var card = "lucas"

var run_mode = false

var invis = false

var mobile = false

var save_menu_place = Vector2(0,0)

var save_menu_place_change_time = false

var animal_pack_bought = false#

var save_menu_scene = ("res://scenes/world.tscn")#

var purple_pack_bought = false#

var mod = ("default")#

var ssCount = 1

var lmcoins = 45#

var shop_color = ("ffffff")#

var time_to_change_pos = false

var in_water_2 = false

var in_water_3 = false

var fri_blast = false

var death = false

var you_just_killed_a_shadow_kid = false

##var player_2_in = false

var fist_time_played = true#

var player_2_in = false

var escape = false

var co_op_unlocked = true#

var player_3_in = false

var death2 = false

var death3 = false

var death4 = false

var in_water = false

var sound = 15

var money = ("0")#

var co_op_deaths = 0

var cameara_player = 1

var total_number_of_players = 1

var on_a_jacoblevel = false#

#hats

var hat_1_on = false

#levels
var level_one_done = false#

var cutscene1_done = false#

var tuturiol_level_done = false#

var jacob_level_1_done = false#

var boss_fight_1_done = false#

var level_two_done = false#

var cutscene_4 = false#

var cutscene_5_done = false#

var strange_signal_level_done = false#

var powered_by_crystals = false

var player_4_in = false

var in_water_4 = false

var level_three_done = false#

var level_four_done = false#

var level_five_done = false#

var world_2_level_1_done = false#

var translated_to_spanish = false

var fire_2 = false

var loginperson = ("none")

var time = Time.get_time_string_from_system()

var level_6_done = false#

var level_7_done = false

var dlc_on = "nothing"

var Level_editor_block = "grass"

var play = false

var base_move_cutscene = false # if magnus have given lucas "kick" and "punch"

var move_set = { # the moves possible to earn
	"kick" : {"name" : "kick","person" : "any","icon" : load("res://assets/kick_icon.png"),"discription" : "Anybody can use, kicks the oponant. granted by M in the base"},
	"punch" : {"name" : "punch","person" : "any","icon" : load("res://assets/punch_icon.png"),"discription" : "Anybody can use, punches the oponant. granted by M in the base"},
	"anucool" : {"name" : "anu cool move","person" : "anurag","icon" : load("res://assets/smobeybobeys_house.png"),"discription" : "anurag is cool"}
	#TODO: make more moves
}

var moves_gotten = { # moves the player has. number is move lv.
	"kick" : 1,
	"punch" : 1,
}

func grant_move(moves : PackedStringArray,player = null):
	base_move_cutscene = true
	for move in moves:
		if moves_gotten.has(move):
			pass
		else:
			moves_gotten[move] = 1
	
	for move in moves:
		move_toast(move)
		await get_tree().create_timer(5.5).timeout
	if player:
		player.lock = false
	print("done granting moves.")

func move_toast(move : String):
	print("you got: ",move)
	var toast_scene = preload("res://scenes/move_toast.tscn")
	var toast = toast_scene.instantiate()
	toast.move_id = move
	add_child(toast)
	await get_tree().create_timer(5.5).timeout
	print("closing popup: ",move) #TODO: make the toast popup close here
	toast.queue_free()


var arcade = false

var level_8_done = false

var pop_up_time = true

var beta_test = false

var auto_load = true

var loaded = false

var version = ""

var input_map = {}

var mod_on

var show_leaderboard_timer = false

var user_info = {"signed_in" : false ,"username": "", "email" : "", "image_url" : ""}

var cloud_load = false

var player_list = []

var score = 0

var score_level = "Empty"

var player_name : String

var app_sign_ins = {}

var lootlock_password = ""

func add_command(_name:String,_callback:Callable,_description:String = "",_usage_example:String = "",_is_cheat:bool = false):
	var command = ConsoleCommand.new(_name)
	command.set_name(_name)
	command.set_callback(_callback)
	command.set_description(_description)
	command.set_usage_example(_usage_example)
	command.set_cheat(_is_cheat)
	Console.add_command(command)

func command_account_info(args):
	Console.print("[color=white]signed_in:
" + str(user_info.signed_in),false,true,"left","gray")
	Console.print("[color=white]username:
" + str(user_info.username),false,true,"left","gray")
	Console.print("[color=white]email:
" + str(user_info.email),false,true,"left","gray")
	Console.print("[color=white]image_url:
" + str(user_info.image_url),false,true,"left","gray")

func command_warp(args):
	print(args)
	if args.size() == 1:
		if FileAccess.file_exists("res://" + args[0]):
			Console.print("changing to " + "res://" + args[0])
			get_tree().change_scene_to_file(args[0])
			Console.print("done!")
			get_tree().set_pause(false)
		else:
			Console.printerr("specified path does not exist!")
	else:
		print(args.size())
		print(args.size() > 1)
		if args.size() > 1:
			Console.printerr("too many args!")
		else:
			Console.printerr("scene not specified!")

func open_save_command(args):
	if FileAccess.file_exists("user://lm_data.json"):
		OS.shell_open(OS.get_user_data_dir() + "/lm_data.json")
	else:
		Console.printerr("There is no save data!")

var waiting = false
func delete_save_command(args):
	if FileAccess.file_exists("user://lm_data.json"):
		Console.printwarn("Are you sure? type \"/confirm_delete\" if so.")
		waiting = true
	else:
		Console.printerr("There is no save data!")
func confirm_delete_save_command(args):
	DirAccess.remove_absolute("user://lm_data.json")
	waiting = false


func _ready():
	Console.name = "LM console"
	Console.enable_console = true
	Console.enable_cheats = true
	add_command("account_info",command_account_info,"get the active account's info","To get your username and id.",false)
	add_command("warp",command_warp,"Go to a scene.","To easily travel around.",true)
	add_command("open_save",open_save_command,"open save","To easily debug saves.",true)
	add_command("delete_save",delete_save_command,"deletes save","To easily delete saves.",false)
	add_command("confirm_delete",confirm_delete_save_command,"deletes save","To easily delete saves.",false)
	
	SilentWolf.configure({
		"api_key" : "dVj5hDbhnL7eQuo7VDpR58hryt4hF2d02sW82n8A",
		"game_id" : "LmSuperheroes",
		"log_level" : 1
	})
	
	SilentWolf.configure_scores({
		"open_scene_on_close" : "res://scenes/MainPage.tscn"
	})
	
	SilentWolf.configure_auth({
		"redirect_to_scene" : "res://Main.tscn",
		"login_scene" : "res://addons/silent_wolf/Auth/Login.tscn",
		"email_confirmation_scene" : "res://addons/silent_wolf/Auth/ConfirmEmail.tscn",
		"reset_password" : "res://addons/silent_wolf/Auth/ResetPassword.tscn",
		"session_duration_seconds" : 0,
		"saved_session_expiration_days" : 30
	})

func _physics_process(delta: float) -> void:
	leaderboard()
	
func leaderboard():
	for score in State.score:
		State.player_list.append(State.player_name)

func instanciate_LeaderboardTimer():
	if not timer_instance:
		var instance = leaderboard_timer.instantiate()
		self.add_child(instance)
		timer_instance = instance

func kill_LeaderboardTimer():
	if timer_instance:
		timer_instance._finish()
		timer_instance.queue_free()
		timer_instance = null

var global_replay

func _input(event):
	if event.is_action_pressed("record"):
		var instance
		if not global_replay:
			var instance_local = replayer.instantiate()
			add_child(instance)
			instance = instance_local
		var replay = instance
		replay.recording = true
		replay.record()
		replay.recorded_objects = get_tree().get_current_scene().get_children()
		current_scene = get_tree().get_current_scene()
		global_replay = replay
	if event.is_action_pressed("stop record"):
		global_replay.recording = false
		global_replay.record()
	
	

func _process(delta):
	if get_tree().get_current_scene() != current_scene:
		current_scene = get_tree().get_current_scene()
