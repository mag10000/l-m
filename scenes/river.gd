extends CharacterBody2D

var date_dict = Time.get_date_dict_from_system()  

var current_month = date_dict["month"]

@export var SPEED = 300.0
var JUMP_VELOCITY = -330.0
var still_jump = false
var coyote_time_started = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	pass


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
		velocity.y += gravity * delta

	if State.player_3_in == true:
		$CollisionShape2D.disabled = false
		self.visible = true
		# Handle jump.
		if Input.is_action_just_pressed("jump_4") && still_jump == true:
			if State.in_water_2 == false:
				still_jump = false
				$AnimatedSprite2D.play("jump")
				velocity.y = JUMP_VELOCITY
			
		if Input.is_action_just_pressed("jump_4") && State.in_water_4 == true:
			velocity.y = JUMP_VELOCITY
		

		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		var direction = Input.get_axis("left_4", "right_4")
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
		
		if direction == 0:
			$AnimatedSprite2D.play("temp")
			$AnimatedSprite2D.flip_h = false
			$AnimatedSprite2D2.flip_h = false
		if direction == 1:
			$AnimatedSprite2D.play("walk")
			$AnimatedSprite2D.flip_h = false
			$AnimatedSprite2D2.flip_h = false
		if direction == -1:
			$AnimatedSprite2D.play("walk")
			$AnimatedSprite2D.flip_h = true
			$AnimatedSprite2D2.flip_h = true

		move_and_slide()



func _process(delta):
	
	if State.loginperson == ("erica"):
		$ColorRect5.visible = true
	
	if State.powered_by_crystals == true:
		$radation.play("default")
	if State.powered_by_crystals == false:
		$radation.play("new_animation")
	
	if State.player_4_in == false:
		velocity.y = 0
		velocity.x = 0
		$CollisionShape2D.disabled = true
		self.visible = false
	if State.in_water_4 == true:
		gravity = 490
		SPEED = 100.0
		JUMP_VELOCITY = -200
		$bubbles_4.play("default")
	if State.in_water_4 == false:
		gravity = 980
		SPEED = 300.0
		JUMP_VELOCITY = -400.0
		$bubbles_4.play("new_animation")

	if State.death4 == true:
		State.co_op_deaths += 1
		queue_free()




func _on_jump_timer_timeout():
	still_jump = false
