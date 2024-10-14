extends Area2D







func _on_body_entered(body):
	State.in_water_2 = true


func _on_body_exited(body):
	State.in_water_2 = false
