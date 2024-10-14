extends Area2D

@onready var game_maneger = %"game_maneger"



func _on_body_entered(body):
	State.money += ("1")
	self.queue_free()
