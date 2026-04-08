extends CharacterBody2D

@export var _name = ""

var camera_checked = false

@export var camera : Camera2D
const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@onready var animated_sprite = $SynchronizedAnimatedSprite2D

func ready():
	$Label.text = State.user_info["username"]
	
	GDSync.connect_gdsync_owner_changed(self, owner_changed)

func owner_changed(owner_id : int) -> void:
	camera_checked = true
	var is_owner : bool = GDSync.is_gdsync_owner(self)
	
	print("is owner? ", is_owner )
	
	camera.enabled = is_owner


func _physics_process(delta):
	$Label.text = State.user_info["username"]
	if !GDSync.is_gdsync_owner(self):
		modulate = "ffffffaa"
		$UI.hide()
		camera.enabled = false
		return
	
	var moveDirection = Input.get_vector("ui_left", "ui_right", "jump", "ui_down")
	velocity = moveDirection * SPEED
	print(velocity)
	
	move_and_slide()
	updateAnimation()

func updateAnimation():
	var anim_direction = "idle"
	if velocity.x < 0:
		anim_direction = "sideways"
		$SynchronizedAnimatedSprite2D.flip_h = false
	elif velocity.x > 0: 
		$SynchronizedAnimatedSprite2D.flip_h = true
		anim_direction = "sideways"
	elif velocity.y > 0: anim_direction = "forward"
	elif velocity.y < 0: anim_direction = "backward"
	
	animated_sprite.play(anim_direction)
