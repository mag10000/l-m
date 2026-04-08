extends Node2D

var move_way = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	if move_way == true:
		$TileMap2.position.x -= 0.04



func _on_timer_2_timeout():
	GDSync.quit()
