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

func _ready():
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
