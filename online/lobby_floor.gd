extends TextureButton

var lobby_name = "I'm a loby"
var password_needed = false
var players = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$name.text = lobby_name
	$player_count.text = "players: " + str(players)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $name.text != lobby_name:
		$name.text = lobby_name
	if $player_count.text != "players: " + str(players):
		$player_count.text = "players: " + str(players)
	if is_hovered():
		$name.hide()
		$player_count.hide()
	else:
		$name.show()
		$player_count.show()


func _on_pressed():
	if not password_needed:
		GDSync.lobby_join(lobby_name)
		await get_tree().create_timer(1).timeout
		$"../../../BaseLoby".show()
		$"../..".hide()
		$"../../../TileMap".hide()
		$"../../../CanvasLayer".hide()
		$"../../../RefreshSign".hide()
		$"../../../Button".hide()
		$"../../../Camera2D".enabled = false
		$"../../../CreateSign".hide()
	if password_needed:
		$auth.show()


func _on_submit_pressed():
	GDSync.lobby_join(lobby_name,$auth/LineEdit.text)
	await get_tree().create_timer(1).timeout
	$"../../../BaseLoby".show()
	$"../..".hide()
	$"../../../TileMap".hide()
	$"../../../CanvasLayer".hide()
	$"../../../RefreshSign".hide()
	$"../../../Button".hide()
	$"../../../Camera2D".enabled = false
	$"../../../CreateSign".hide()
