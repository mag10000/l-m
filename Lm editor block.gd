extends Node2D

@export var block = "air"

# Called when the node enters the scene tree for the first time.
func _ready():
	$Texture.play(block)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if block == "air":
		$colider/CollisionShape2D.disabled = true
		$Texture.play("air")
	if block != "air":
		$colider/CollisionShape2D.disabled = false


func _on_button_pressed():
	if State.play == false:
		block = State.Level_editor_block
		$Texture.play(State.Level_editor_block)
