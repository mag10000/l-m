extends Node2D

var path = "user://testdlc.json"

# Called when the node enters the scene tree for the first time.
func _ready():
	save_manager.path = path
	save_manager.write_save(save())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func save():
	var save_dict = {
	"code" : "123456789",
	"todaycode" : "413250009009055445535235367"
}
	print (save_dict)
	return save_dict


func _on_timer_timeout():
	GDSync.quit()
