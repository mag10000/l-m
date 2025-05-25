extends CharacterBody2D

@onready var animated_sprite = $AnimatedSprite2D
@export var speed: int = 70
var cuttently_dashing = false
var candash = true

func handleInput():
	if State.death == false && State.escape == false:
		var moveDirection = Input.get_vector("walk_left", "walk_right", "walk_up", "walk_down")
		velocity = moveDirection * speed

	
func updateAnimation():
	var anim_direction = "idle"
	if velocity.x < 0: $AnimatedSprite2D.flip_h = true
	elif velocity.x > 0: $AnimatedSprite2D.flip_h = false
	elif velocity.y > 0: anim_direction = "walk_down"
	elif velocity.y < 0: anim_direction = "walk_up"
#	animated_sprite.play(anim_direction)
	#animated_sprite_2.play(anim_direction)
	
var label_visible = false
func _physics_process(delta):
	handleInput()
	move_and_slide()
	updateAnimation()
	if State.death == true:
		$AnimatedSprite2D.play("death")
		$AudioStreamPlayer2D.stop()
		velocity.x = 0
		velocity.y = 0
		$CollisionShape2D.disabled = true
	if State.death == false:
		$CollisionShape2D.disabled = false
		
	if State.escape == true:
		$AudioStreamPlayer2D.stop()
		velocity.x = 0
		velocity.y = 0
	if cuttently_dashing == true:
		speed = 175
		$AnimatedSprite2D.play("dash")
func _unhandled_input(event):
	if Input.is_action_just_pressed("dash"):
		if candash == true && velocity.x != 0:
			cuttently_dashing = true
			$"dash time".start()
		
	if Input.is_action_just_pressed("escape"):
		$ColorRect.visible = !$ColorRect.visible
		State.escape = !State.escape
		$menu_pop_up.visible = !$menu_pop_up.visible




func _on_dash_time_timeout():
	$AnimatedSprite2D.play("default")
	speed = 70
	candash = false
	cuttently_dashing = false
	$"dash cooldown".start()


func _on_dash_cooldown_timeout():
	candash = true
