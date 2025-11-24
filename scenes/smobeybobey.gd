extends Node2D

@export var health = 3

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if State.fri_blast == true:
		$AnimatedSprite2D2.play("fri_blast")
	if State.fri_blast == false:
		$AnimatedSprite2D2.play("nothing")

	if health == 0:
		State.boss_fight_1_done = true
		queue_free()

	print(health)


func _on_timer_timeout():
	$Timer.stop()
	State.fri_blast = true
	$AnimatedSprite2D2/killzone/CollisionShape2D.disabled = false
	$Timer2.start(2)

func _on_timer_2_timeout():
	$Timer2.stop()
	State.fri_blast = false
	$AnimatedSprite2D2/killzone/CollisionShape2D.disabled = true
	$Timer.start(10)


func _on_area_2d_body_entered(body):
	health -= 1
	$Area2D/CollisionShape2D.disabled = true
	$Timer3.start()
	$AnimatedSprite2D.play("hit")



func _on_timer_3_timeout():
	$Timer3.stop()
	$Area2D/CollisionShape2D.disabled = false
	$AnimatedSprite2D.play("default")
