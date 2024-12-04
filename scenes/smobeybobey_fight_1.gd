extends Node2D


var smobeybobeys_turn = false
var smobeybobeys_turn_started = false
@export var health = 1000
@export var player_health = 900
var times_used_worm = 0
var enemy_moves_times = 1
var death_time = false


# Called when the node enters the scene tree for the first time.
func _ready():
	$lucas.position = Vector2(71,2240)



func _process(delta):
	#translations
	if State.translated_to_spanish == true:
		$team_health.text = ("salud de tu equipo:")
		$Lucas_box/worm_attck.text = ("gusano")
		$Lucas_box/snake_attck.text = ("serpiente")
		$Magnus_box/mind_bubble_attck.text = ("burbuja mental")
		$Magnus_box/mind_blast_attck.text = ("explosión mental")
		$ian_box/shovel_dig_attack.text = ("cavar con pala")
		$ian_box/shovel_stab_attack.text = ("puñalada de pala")
	else:
		$team_health.text = ("your teams health:")
		$Lucas_box/worm_attck.text = ("worm")
		$Lucas_box/snake_attck.text = ("snake")
		$Magnus_box/mind_bubble_attck.text = ("mind bubble")
		$Magnus_box/mind_blast_attck.text = ("mind blast")
		$ian_box/shovel_dig_attack.text = ("shovel dig")
		$ian_box/shovel_stab_attack.text = ("shovel stab")







	if times_used_worm >= 4:
		$Lucas_box/worm_attck.disabled = true
	var player_health_string = str(player_health)
	var health_string = str(health)
	$smobeybobey/health_smobeybobey.text = health_string
	$team_health/Label.text = player_health_string
	if enemy_moves_times >= 10:
		enemy_moves_times = 1
	if State.player_2_in == false && State.player_3_in == false:
		$smobeybobey.position = Vector2(94,2240)
	if State.player_2_in == true:
		$Magnus_box.visible = true
		$smobeybobey.position = Vector2(183,2240)
		$magnus.visible = true
	if State.player_3_in == true:
		$ian_box.visible = true
		$smobeybobey.position = Vector2(274,2240)
	if player_health <= 1 && death_time == false:
		death_time = true
		player_health = 0
		Engine.time_scale = 0.5
		$Lucas_box/snake_attck.disabled = true
		$Lucas_box/worm_attck.disabled = true
		$Magnus_box/mind_bubble_attck.disabled = true
		$Magnus_box/mind_blast_attck.disabled = true
		$death_player.play()
		$death_timer.start()
	if health <= 1:
		State.boss_fight_1_done = true
		State.save_menu_scene = ("res://scenes/base.tscn")
		get_tree().change_scene_to_file("res://scenes/loading_screen.tscn")
	if smobeybobeys_turn == true && smobeybobeys_turn_started == false:
		smobeybobeys_turn_started = true
		$smobeybobey/AnimatedSprite2D.play("blast")
		$fry_blast_timer.start()
		$Lucas_box/snake_attck.disabled = true
		$Lucas_box/worm_attck.disabled = true
		$Magnus_box/mind_bubble_attck.disabled = true
		$Magnus_box/mind_blast_attck.disabled = true
func _on_fry_blast_timer_timeout():
	$fry_blast_timer.stop()
	$smobeybobey/AnimatedSprite2D.play("default")
	smobeybobeys_turn = false
	smobeybobeys_turn_started = false
	$Lucas_box/snake_attck.disabled = false
	$Lucas_box/worm_attck.disabled = false
	$Magnus_box/mind_bubble_attck.disabled = false
	$Magnus_box/mind_blast_attck.disabled = false
	if enemy_moves_times <= 3:
		player_health -= 54
	if enemy_moves_times >= 2 && enemy_moves_times <= 7:
		player_health -= 37
	if enemy_moves_times == 7:
		player_health -= 43
	if enemy_moves_times == 8:
		player_health -= 37
	if enemy_moves_times >= 8:
		player_health -= 31
	enemy_moves_times += 1
	print("player_health")
	print(player_health)



#lucas's Attacks

#Lucas Snake Attack
func _on_snake_attck_pressed():
	$lucas.play("snake_attck")
	$snake_timer.start()
	$Lucas_box/snake_attck.disabled = true
	$Lucas_box/worm_attck.disabled = true
	$Magnus_box/mind_bubble_attck.disabled = true
	$Magnus_box/mind_blast_attck.disabled = true
	if State.player_3_in == false && State.player_2_in == false:
		$lucas.position = Vector2(71,2240)
	if State.player_2_in == true:
		$lucas.position = Vector2(160,2240)
	if State.player_3_in == true:
		$lucas.position = Vector2(251,2240)
func _on_snake_timer_timeout():
	$lucas.play("default")
	$lucas.position = Vector2(71,2240)
	$snake_timer.stop()
	$Lucas_box/snake_attck.disabled = false
	$Lucas_box/worm_attck.disabled = false
	$Magnus_box/mind_bubble_attck.disabled = false
	$Magnus_box/mind_blast_attck.disabled = false
	health -= 50
	smobeybobeys_turn = true

#Lucas Worm Atack
func _on_worm_attck_pressed():
	$lucas.play("worm_attck")
	$worm_timer.start()
	$Lucas_box/snake_attck.disabled = true
	$Lucas_box/worm_attck.disabled = true
	$Magnus_box/mind_bubble_attck.disabled = true
	$Magnus_box/mind_blast_attck.disabled = true
	if State.player_3_in == false && State.player_2_in == false:
		$lucas.position = Vector2(71,2240)
	if State.player_2_in == true:
		$lucas.position = Vector2(160,2240)
	if State.player_3_in == true:
		$lucas.position = Vector2(251,2240)
func _on_worm_timer_timeout():
	$lucas.play("default")
	$lucas.position = Vector2(71,2240)
	$worm_timer.stop()
	$Lucas_box/snake_attck.disabled = false
	$Lucas_box/worm_attck.disabled = false
	$Magnus_box/mind_bubble_attck.disabled = false
	$Magnus_box/mind_blast_attck.disabled = false
	times_used_worm += 1
	health -= 100
	smobeybobeys_turn = true

#Magnus's Attacks

#Mind Bubble
func _on_mind_bubble_attck_pressed():
	$magnus_attacks.play("mind_bubble")
	$bubble_timer.start()
	$Lucas_box/snake_attck.disabled = true
	$Lucas_box/worm_attck.disabled = true
	$Magnus_box/mind_bubble_attck.disabled = true
	$Magnus_box/mind_blast_attck.disabled = true
	if State.player_3_in == false:
		$magnus_attacks.position = Vector2(160,2240)
	if State.player_3_in == true:
		$magnus_attacks.position = Vector2(238,2240)
func _on_bubble_timer_timeout():
	$magnus_attacks.play("default")
	$magnus_attacks.position = Vector2(160,2240)
	$bubble_timer.stop()
	$Lucas_box/snake_attck.disabled = false
	$Lucas_box/worm_attck.disabled = false
	$Magnus_box/mind_bubble_attck.disabled = false
	$Magnus_box/mind_blast_attck.disabled = false
	health -= 50
	smobeybobeys_turn = true

#Mind blast
func _on_mind_blast_attck_pressed():
	$magnus_attacks.play("mind_blast")
	$mind_blast_timer.start()
	$Lucas_box/snake_attck.disabled = true
	$Lucas_box/worm_attck.disabled = true
	$Magnus_box/mind_bubble_attck.disabled = true
	$Magnus_box/mind_blast_attck.disabled = true
	if State.player_3_in == false:
		$magnus_attacks.position = Vector2(160,2240)
	if State.player_3_in == true:
		$magnus_attacks.position = Vector2(238,2240)
func _on_mind_blast_timer_timeout():
	$magnus_attacks.play("default")
	$magnus_attacks.position = Vector2(160,2240)
	$mind_blast_timer.stop()
	$Lucas_box/snake_attck.disabled = false
	$Lucas_box/worm_attck.disabled = false
	$Magnus_box/mind_bubble_attck.disabled = false
	$Magnus_box/mind_blast_attck.disabled = false
	health -= 45
	smobeybobeys_turn = true



func _on_button_2_pressed():
	if $Camera2D.zoom.x <= 6:
		$Camera2D.zoom.y += 1
		$Camera2D.zoom.x += 1


func _on_button_3_pressed():
	$Camera2D.zoom.y -= 1
	$Camera2D.zoom.x -= 1






func _on_death_timer_timeout():
	Engine.time_scale = 1.0
	health = 1000
	player_health = 0
	death_time = false
	get_tree().reload_current_scene()
