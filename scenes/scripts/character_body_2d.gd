extends CharacterBody2D


@export var SPEED = 250.0
var JUMP_VELOCITY = -350.0
var still_jump = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var timer = false

func _physics_process(delta):
	if is_on_floor():
		still_jump = true
	if not is_on_floor ():
		still_jump = true
		$jump_timer.start()
	# Add the gravity.
	if not is_on_floor ():
		if State.death == false:
			velocity.y += gravity * delta
	#if is_on_floor ():
		#$AnimatedSprite2D.play("temp")
	if State.escape == false && State.death == false:
	# Handle jump.
		if Input.is_action_just_pressed("jump") && still_jump == true:
			if State.death == false && State.in_water == false:
				velocity.y = JUMP_VELOCITY
				
		if Input.is_action_just_pressed("jump") && State.in_water == true:
			$AnimatedSprite2D.play("water_jump")
			velocity.y = JUMP_VELOCITY

		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		var direction = Input.get_axis("walk_left", "walk_right")
		if State.death == false:
			if direction:
				velocity.x = direction * SPEED
			else:
				velocity.x = move_toward(velocity.x, 0, SPEED)
		if direction == 0 && State.in_water == false:
			$AnimatedSprite2D.flip_h = false
			$AnimatedSprite2D.play("idle")
			$hat_lucas.play("idle")
			$hat_lucas.flip_h = false
			
		if direction > 0 && State.in_water == false:
			$AnimatedSprite2D.play("walk")
			$AnimatedSprite2D.flip_h = false
			$hat_lucas.play("walk")
			$hat_lucas.flip_h = false
			
			
		if direction < 0 && State.in_water == false:
			$AnimatedSprite2D.play("walk")
			$AnimatedSprite2D.flip_h = true
			$hat_lucas.play("walk")
			$hat_lucas.flip_h = true
			
		move_and_slide()
	
func _unhandled_input(event):
	if Input.is_action_just_pressed("jump") and is_on_floor():
		$AudioStreamPlayer2D.play()
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
		State.escape = false
		#Engine.time_scale = 0.5
		$CollisionShape2D.disabled = true
	if State.hat_1_on == false:
		$hat_lucas.visible = false
	else:
		$hat_lucas.visible = true
	if State.in_water == true:
		SPEED = 100.0
		JUMP_VELOCITY = -250
		$bubles.play("default")
		if is_on_floor():
			$AnimatedSprite2D.play("idle")
		if not is_on_floor ():
			$AnimatedSprite2D.play("water_jump")
	else:
		SPEED = 250.0
		JUMP_VELOCITY = -350
		$bubles.play("new_animation")

	
	
	if State.escape == true:
		Engine.time_scale = 0
	if State.escape == false && State.death == false && State.death2 == false && State.death3 == false:
		Engine.time_scale = 1.0
	State.save_menu_place = self.position
	print(State.save_menu_place)
	
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
