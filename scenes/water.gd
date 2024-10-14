extends Area2D



func _on_body_entered(body):
	State.in_water = true


func _on_body_exited(body):
	State.in_water = false
