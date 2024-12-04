extends CharacterBody2D

@export var SPEED = 300.0
var JUMP_VELOCITY = -400.0
var still_jump = false
var coyote_time_started = false
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	
	#handles coyote time
	if is_on_floor():
		still_jump = true
		coyote_time_started = false
	if not is_on_floor () && coyote_time_started == false:
		coyote_time_started = true
		$jump_timer.start()
	
	# Add the gravity.
	if not is_on_floor():
		$AnimatedSprite2D.play("jump")
		velocity.y += gravity * delta
		
		
	if State.player_3_in == false:
		velocity.y = 0
		velocity.x = 0
		$CollisionShape2D.disabled = true
		visible = false
	else:
		visible = true
		$CollisionShape2D.disabled = false
		
		if Input.is_action_just_pressed("jump_3") && still_jump == true:
			if State.in_water_2 == false:
				still_jump = false
				velocity.y = JUMP_VELOCITY
			
		if Input.is_action_just_pressed("jump_3") && State.in_water_3 == true:
			velocity.y = JUMP_VELOCITY

		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		var direction = Input.get_axis("left_3", "right_3")
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
		if direction == 1:
			$AnimatedSprite2D.play("walk")
			$AnimatedSprite2D.flip_h = false
			$AnimatedSprite2D2.flip_h = false
		if direction == -1:
			$AnimatedSprite2D.play("walk")
			$AnimatedSprite2D.flip_h = true
			$AnimatedSprite2D2.flip_h = true
		if direction == 0:
			$AnimatedSprite2D.play("temp")
			$AnimatedSprite2D.flip_h = false
			$AnimatedSprite2D2.flip_h = false
		if State.player_3_in:
			direction == 0
	move_and_slide()
	if State.death3 == true:
		State.co_op_deaths += 1
		queue_free()
	
	if State.in_water_3 == true:
		SPEED = 100.0
		JUMP_VELOCITY = -250
		$bubbles_3.play("default")
	if State.in_water_3 == false:
		SPEED = 300.0
		JUMP_VELOCITY = -400.0
		$bubbles_3.play("new_animation")
	if State.powered_by_crystals == true:
		$radation.play("default")
	if State.powered_by_crystals == false:
		$radation.play("new_animation")



func _on_jump_timer_timeout():
	still_jump = false
