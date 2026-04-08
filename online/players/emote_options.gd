extends HBoxContainer

@onready var text_bubble = %TextBubbbleLm
@onready var bubble_label = %bubble_emote

# Called when the node enters the scene tree for the first time.
func _ready():
	text_bubble.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func send_msg(message : String):
	%bubble_text.text = ""
	bubble_label.add_theme_font_size_override("font_size",32)
	bubble_label.add_theme_font_override("font",load("res://assets/fonts/Unifontexmono-lxY45.ttf"))
	text_bubble.show()
	bubble_label.text = message
	await get_tree().create_timer(2.5).timeout
	text_bubble.hide()



func _on_left_pressed():
	send_msg("←")


func _on_right_pressed():
	send_msg("→")


func _on_smile_pressed():
	send_msg("😊")


func _on_explode_pressed():
	send_msg("🤯")


func _on_mad_pressed():
	send_msg("😡")


func _on_cursing_pressed():
	send_msg("🤬")


func _on_poop_pressed():
	send_msg("💩")


func _on_hand_peace_pressed():
	send_msg("👌")


func _on_love_pressed():
	send_msg("😍")


func _on_sleep_pressed():
	send_msg("😴")


func _on_star_face_pressed():
	send_msg("🤩")


func _on_netral_pressed():
	send_msg("😐")


func _on_hearts_pressed():
	send_msg("💕")


func _on_thumvb_up_pressed():
	send_msg("👍")


func _on_thumvb_down_pressed():
	send_msg("👎")


func _on_disgust_pressed():
	send_msg("🤢")
