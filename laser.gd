extends Node2D

@export var mode = true
var once = false
var _signal = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if State.powered_by_crystals == true:
		$killzone2/CollisionShape2D.disabled = true
		$killzone/CollisionShape2D.disabled = true
		$killzone3/CollisionShape2D.disabled = true
		$killzone4/CollisionShape2D.disabled = true
	else:
		$killzone2/CollisionShape2D.disabled = false
		$killzone/CollisionShape2D.disabled = false
		$killzone3/CollisionShape2D.disabled = false
		$killzone4/CollisionShape2D.disabled = false




	if mode == true:
		$AnimatedSprite2D.play("default")
		$killzone/CollisionShape2D.disabled = false
		$killzone4/CollisionShape2D.disabled = false
		$killzone3/CollisionShape2D.disabled = false
		$killzone2/CollisionShape2D.disabled = false
	if mode == false:
		$AnimatedSprite2D.play("none")
		$killzone/CollisionShape2D.disabled = true
		$killzone4/CollisionShape2D.disabled = true
		$killzone3/CollisionShape2D.disabled = true
		$killzone2/CollisionShape2D.disabled = true

func _on_timer_timeout():
	mode = !mode




