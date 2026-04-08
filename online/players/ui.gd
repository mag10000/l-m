extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	$Control/chat_button.show()
	$Control/chat_panel.hide()
	$Control/emote_button.show()
	$Control/emote_panel.hide()
	if TranslationServer.get_locale().contains("cmn") or TranslationServer.get_locale().contains("ja"):
		$"Control/chat_panel/ScrollContainer/chat options/HI".add_theme_font_size_override("font_size",12)
		$"Control/chat_panel/ScrollContainer/chat options/HELLO".add_theme_font_size_override("font_size",12)
		$"Control/chat_panel/ScrollContainer/chat options/OOPS__".add_theme_font_size_override("normal_font_size",12)
		$"Control/chat_panel/ScrollContainer/chat options/SORRY".add_theme_font_size_override("font_size",12)
		$"Control/chat_panel/ScrollContainer/chat options/ANURAG!!".add_theme_font_size_override("font_size",12)
		$"Control/chat_panel/ScrollContainer/chat options/HI".hide()
		%bubble_text2.add_theme_font_size_override("font_size",12)
	if TranslationServer.get_locale().contains("ko"):
		$"Control/chat_panel/ScrollContainer/chat options/HI".add_theme_font_size_override("font_size",24)
		$"Control/chat_panel/ScrollContainer/chat options/HELLO".add_theme_font_size_override("font_size",24)
		$"Control/chat_panel/ScrollContainer/chat options/OOPS__".add_theme_font_size_override("normal_font_size",24)
		$"Control/chat_panel/ScrollContainer/chat options/SORRY".add_theme_font_size_override("font_size",24)
		$"Control/chat_panel/ScrollContainer/chat options/ANURAG!!".add_theme_font_size_override("font_size",24)
		%bubble_text2.add_theme_font_size_override("font_size",12)
	if TranslationServer.get_locale().contains("es"):
		$"Control/chat_panel/ScrollContainer/chat options/HI".hide()
	if TranslationServer.get_locale().contains("pl"):
		$"Control/chat_panel/ScrollContainer/chat options/HI".hide()

var text = ""

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if text != %bubble_text.text:
		%bubble_text2.text = tr(%bubble_text.text)


func _on_chat_button_pressed():
	$Control/chat_button.hide()
	$Control/chat_panel.show()


func _on_emote_button_pressed():
	$Control/emote_button.hide()
	$Control/emote_panel.show()
