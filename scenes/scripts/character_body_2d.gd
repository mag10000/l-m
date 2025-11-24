extends CharacterBody2D

var in_air = false
var date_dict = Time.get_date_dict_from_system()  

var current_month = date_dict["month"]

var current_idle = ("idle")

var current_conroller = 0
var _1 = false
@export var SPEED = 250.0
var JUMP_VELOCITY = -350.0
var still_jump = false
var coyote_time_started = false
var noth = false
var pos_2 = Vector2(1,1)
var pos_3 = Vector2(1,1)
var pos_4 = Vector2(1,1)
var camera_following = 1
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var timer = false

func _ready():
	if OS.get_name() == "Windows":
		var user = OS.get_environment("USERNAME")
		if FileAccess.file_exists("C:\\Users\\"+user+"\\Documents\\LMJumpSound\\Jump.wav"):
			$AudioStreamPlayer2D.stream = load("C:\\Users\\"+user+"\\Documents\\LMJumpSound\\Jump.wav")


		#if FileAccess.file_exists("C:\\Users\\"+user+"\\Documents\\LMdlc\\farmer\\on.txt"):
			#if FileAccess.file_exists("C:\\Users\\"+user+"\\Documents\\LMdlc\\farmer\\p1animation_GARDEN.tres"):
				#State.mod = "override"
				#$AnimatedSprite2D.sprite_frames = load("C:\\Users\\"+user+"\\Documents\\LMdlc\\farmer\\p1animation_GARDEN.tres")


		#if FileAccess.file_exists("C:\\Users\\"+user+"\\Documents\\LMdlc\\purple skins\\on.txt"):
			#if FileAccess.file_exists("C:\\Users\\"+user+"\\Documents\\LMdlc\\purple skins\\p1animation_mod.tres"):
				#State.mod = "override"
				#$AnimatedSprite2D.sprite_frames = load("res://mods/purple skins/p1animation_mod_purple.tres")


		#if FileAccess.file_exists("C:\\Users\\"+user+"\\Documents\\LMdlc\\back to school\\on.txt"):
			#if FileAccess.file_exists("C:\\Users\\"+user+"\\Documents\\LMdlc\\back to school\\p1animation.tres"):
				#State.mod = "override"
				#$AnimatedSprite2D.sprite_frames = load("res://mods/back to school/p1animation.tres")

	
	if State.window_saftey == false:
		var user = OS.get_environment("USERNAME")
		if FileAccess.file_exists("C:\\Users\\"+user+"\\Documents\\LMJumpSound\\Jump.wav"):
			$AudioStreamPlayer2D.stream = load("C:\\Users\\"+user+"\\Documents\\LMJumpSound\\Jump.wav")
		if FileAccess.file_exists("C:\\Users\\"+user+"\\Documents\\LMdlc\\farmer\\on.txt"):
			State.mod = "override"
			$AnimatedSprite2D.sprite_frames = load("C:\\Users\\"+user+"\\Documents\\LMdlc\\farmer\\p1animation_GARDEN.tres")



func _physics_process(delta):
	
	
	#handles coyote time
	
	print(coyote_time_started)
	if is_on_floor():
		still_jump = true
		coyote_time_started = false
	if not is_on_floor () && coyote_time_started == false:
		coyote_time_started = true
		$jump_timer.start()
		
		if is_on_floor():
			if in_air == true:
				in_air = false
				Input.start_joy_vibration(0,0.7,0,0.1)
		
		
	# Add the gravity.
	if not is_on_floor ():
		if State.death == false:
			velocity.y += gravity * delta
	#if is_on_floor ():
		#$AnimatedSprite2D.play("temp")
	if State.escape == false && State.death == false:
		
		if Input.is_action_just_pressed("jump") && in_air == false:
			if State.death == false && State.in_water == false:
				in_air == true
	# Handle jump.
		if Input.is_action_just_pressed("jump") && still_jump == true:
			if State.death == false && State.in_water == false:
				still_jump = false
				$AudioStreamPlayer2D.play()
				velocity.y = JUMP_VELOCITY
				
		if Input.is_action_just_pressed("jump") && State.in_water == true:
			$AnimatedSprite2D.play("water_jump")
			velocity.y = JUMP_VELOCITY

		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		var direction = Input.get_axis("walk_left", "walk_right")
		if State.death == false && noth == false:
			if direction:
				velocity.x = direction * SPEED
			else:
				velocity.x = move_toward(velocity.x, 0, SPEED)
			
			
			
			
			
		if direction == 0 and is_on_floor():
			$AnimatedSprite2D.flip_h = false
			$AnimatedSprite2D.play(current_idle)
			$hat_lucas.play(current_idle)
			$hat_lucas.flip_h = false
			$AnimatedSprite2D2.flip_h = false
		if direction > 0 and is_on_floor():
			$AnimatedSprite2D.play("walk")
			$AnimatedSprite2D.flip_h = false
			$hat_lucas.play("walk")
			$hat_lucas.flip_h = false
			$AnimatedSprite2D2.flip_h = false
			
		if direction < 0 and is_on_floor():
			$AnimatedSprite2D.play("left")
			#$AnimatedSprite2D.flip_h = true
			$hat_lucas.play("walk")
			$hat_lucas.flip_h = true
			
		if direction > 0 && State.in_water == false:
			$AnimatedSprite2D.play("walk")
			$AnimatedSprite2D.flip_h = false
			$hat_lucas.play("walk")
			$hat_lucas.flip_h = false
			$AnimatedSprite2D2.flip_h = false
			
			
		if direction < 0 && State.in_water == false:
			$AnimatedSprite2D.play("left")
			$hat_lucas.play("walk")
			$hat_lucas.flip_h = true
			
		if direction == 0 && State.in_water == false:
			$AnimatedSprite2D.flip_h = false
			$AnimatedSprite2D.play(current_idle)
			$hat_lucas.play(current_idle)
			$hat_lucas.flip_h = false
			$AnimatedSprite2D2.flip_h = false



		move_and_slide()
	

func _input(event : InputEvent) -> void:
	if event is InputEventJoypadMotion or event is InputEventJoypadButton:
		current_conroller = event.device

func _unhandled_input(event):
	if Input.is_action_just_pressed("jump") && State.in_water == true:
		pass
		##$AnimatedSprite2D.play("jump")
	#if Input.is_action_just_pressed("walk_right") and is_on_floor():
		#$AnimatedSprite2D.play("walk")
		#$AnimatedSprite2D.flip_h = false
	#if Input.is_action_just_pressed("walk_left") and is_on_floor():
		#$AnimatedSprite2D.play("walk")
		#$AnimatedSprite2D.flip_h = true
	if Input.is_action_just_pressed("escape") && State.death == false and is_on_floor ():
		State.escape = !State.escape
		$menu_pop_up.visible = !$menu_pop_up.visible
func _process(delta):
	
	
	
	
	
	if State.run_mode == true:
		Input.action_press("walk_right")

	if State.invis == true:
		$AnimatedSprite2D.visible = false
	
	if State.mod == ("purple skins"):
		$AnimatedSprite2D.sprite_frames = load("res://mods/purple skins/p1animation_mod.tres")
	if State.mod == ("animal skins"):
		$AnimatedSprite2D.sprite_frames = load("res://mods/animal skins/p1animation_mod.tres")
	if State.mod == ("default"):
		$AnimatedSprite2D.sprite_frames = load("res://scenes/p1animation.tres")
	
	if current_month == 12:
		current_idle = ("temp")
		$AnimatedSprite2D2.play("default")
	var current_day = date_dict["day"]
	if current_month == 10 && current_day == 31:
		current_idle = ("temp")
		$AnimatedSprite2D2.play("hallo")
	if State.loginperson == ("erica"):
		$ColorRect5.visible = true
	
	if State.death2 == true:
		print("not here")
	
	if State.player_2_in == false:
		State.total_number_of_players = 1
	if State.player_2_in == true && State.player_3_in == false:
		State.total_number_of_players = 2
	if State.player_3_in == true && State.player_4_in == false:
		State.total_number_of_players = 3
	if State.player_4_in == true:
		State.total_number_of_players = 4
	if State.you_just_killed_a_shadow_kid == true:
		#$shadow_kid_kill_vo/Timer3.start()
		State.you_just_killed_a_shadow_kid = false
		$shadow_kid_kill_vo.play()
	if State.powered_by_crystals == true:
		$radation.play("default")
	if State.powered_by_crystals == false:
		$radation.play("new_animation")
	if State.death == true:
		$AnimatedSprite2D.play("death")





		if State.player_2_in == true:
			$AnimatedSprite2D2.visible = false
			$AnimatedSprite2D.play("noth")
			noth = true
			if State.death2 == false :
				State.cameara_player = 2
				$"../player2/Camera2D".make_current()
			if State.death == true && State.death2 == true && State.death3 == false:
				State.cameara_player = 3
				$"../ian/Camera2D".make_current()
			if State.death == true && State.death3 == true && State.death2 == true && State.death4 == false:
				State.cameara_player = 4
				$"../tall_boi/Camera2D".make_current()
			if State.total_number_of_players == 2 && State.death2 == true:
				$Camera2D.make_current()
				State.death = false
				State.death2 = false
				State.death3 = false
				State.death4 = false
				get_tree().reload_current_scene()
			if State.total_number_of_players == 3 && State.death2 == true && State.death3 == true:
				$Camera2D.make_current()
				State.death = false
				State.death2 = false
				State.death3 = false
				State.death4 = false
				get_tree().reload_current_scene()
			if State.total_number_of_players == 4 && State.death2 == true && State.death3 == true && State.death4 == true:
				$Camera2D.make_current()
				State.death = false
				State.death2 = false
				State.death3 = false
				State.death4 = false
				get_tree().reload_current_scene()
			if State.death == true && State.death2 == true && State.death3 == true && State.death4 == true:
				$Camera2D.make_current()
				State.death = false
				State.death2 = false
				State.death3 = false
				State.death4 = false
				get_tree().reload_current_scene()
		if State.player_2_in == false:
			State.escape = false
		$CollisionShape2D.disabled = true





	if State.hat_1_on == false:
		$hat_lucas.visible = false
	else:
		$hat_lucas.visible = true
	if State.in_water == true:
		gravity = 490
		SPEED = 100.0
		JUMP_VELOCITY = -200
		$bubles.play("default")
		if not is_on_floor ():
			$AnimatedSprite2D.play("water_jump")
	else:
		gravity = 980
		SPEED = 250.0
		JUMP_VELOCITY = -350
		$bubles.play("new_animation")

	
	
	if State.escape == true:
		Engine.time_scale = 0
	if State.escape == false && State.death == false && State.death2 == false && State.death3 == false:
		Engine.time_scale = 1.0
	State.save_menu_place = self.position
	#print(State.save_menu_place)
	
	if State.save_menu_place_change_time == true:
		$Timer2.start()
func _on_timer_timeout():
	timer = true
	




func _on_timer_2_timeout():
	self.position = State.save_menu_place
	State.save_menu_place_change_time = false


func _on_timer_3_timeout():
	State.you_just_killed_a_shadow_kid = false





func _on_jump_timer_timeout():
	still_jump = false




func _on_rumble_body_entered(body):
	Input.start_joy_vibration(0,0.7,0,0.0654321)
