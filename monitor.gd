extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	await RenderingServer.frame_post_draw
	
	var viewport = get_viewport()
	$"../TextureRect".texture = viewport.get_texture().get_image()
