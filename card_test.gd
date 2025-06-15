extends Node3D

var rot = "<"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	$lucas.rotation = $layla.rotation
	
	if State.card == "lucas":
		$lucas.visible = true
		$layla.visible = false


