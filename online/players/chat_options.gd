extends HBoxContainer

@onready var text_bubble = %TextBubbbleLm
@onready var bubble_label = %bubble_text

# Called when the node enters the scene tree for the first time.
func _ready():
	text_bubble.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func send_msg(message : String):
	%bubble_emote.text = ""
	bubble_label.add_theme_font_size_override("font_size",8)
	bubble_label.add_theme_font_override("font",load("res://assets/fonts/PressStart2P-Regular.ttf"))
	text_bubble.show()
	bubble_label.text = message
	await get_tree().create_timer(2.5).timeout
	text_bubble.hide()


func _on_hi_pressed():
	send_msg("Hi")


func _on_hello_pressed():
	send_msg("Hello")


func _on_anurag_pressed():
	send_msg("ANURAG!!")


func _on_sorry_pressed():
	send_msg("Sorry")


func _on_oops___pressed():
	send_msg("Oops..")
