extends Camera3D



#Lm Superheroes

# Called when the node enters the scene tree for the first time.
func _ready():
	var dir = DirAccess.open("user://")
	dir.make_dir("screenshots")
	
	dir = DirAccess.open("user://screenshots")
	for n in dir.get_files():
		State.ssCount += 1
	

func _input(event):
	if event.is_action_pressed("screenshot"):
		print("yay!")
		screenshot()

func screenshot():
	await RenderingServer.frame_post_draw
	
	var viewport = get_viewport()
	var img = viewport.get_texture().get_image()
	img.save_png("user://screenshots/screenshot"+str(State.ssCount)+".png")
	State.ssCount += 1
	var user = OS.get_environment("USERNAME")
	OS.shell_open("C:\\Users\\" + user + "\\AppData\\Roaming\\Lm Superheroes\\screenshots")
