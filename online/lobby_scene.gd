extends Control

@onready var lobby_thing = preload("res://online/lobby_floor.tscn")
var need_password = false
var password = ""

var authed = false

func _ready():
	print(TranslationServer.get_locale_name(TranslationServer.get_locale()))
	
	GDSync.connected.connect(connected)
	GDSync.connection_failed.connect(connection_failed)
	
	GDSync.lobby_created.connect(lobby_created)
	GDSync.lobby_creation_failed.connect(lobby_creation_failed)
	
	GDSync.lobby_joined.connect(lobby_joined)
	GDSync.lobby_join_failed.connect(lobby_join_failed)
	
	GDSync.lobbies_received.connect(lobbies_recived)
	
	$CanvasLayer/Loading.show()
	GDSync.start_multiplayer()
	
	
	#GDSync.lobby_received(lobby : Dictionary)



func connected() -> void:
	print("Connected!")
	$CanvasLayer/Loading.hide()
	
	#GDSync.lobby_create("MagnusLobby","",true, 4)
	
	get_lobbies()

func connection_failed(error : int) -> void:
	match(error):
		ENUMS.CONNECTION_FAILED.INVALID_PUBLIC_KEY:
			push_error("The public or private key you entered is not valiad")
		ENUMS.CONNECTION_FAILED.TIMEOUT:
			push_error("Unable to connect, please check your internet connection")

func lobby_created(lobby_name : String) -> void:
	print("Created lobby ", lobby_name)
	
	if not need_password:
		GDSync.lobby_join(lobby_name)
	else:
		need_password = false
		GDSync.lobby_join(lobby_name,password)

func show_objects():
	$BaseLoby.hide()
	$tower.show()
	$TileMap.show()
	$CanvasLayer.show()
	$RefreshSign.show()
	$Button.show()
	$CreateSign.show()
	$Camera2D.enabled = true


func lobby_creation_failed(lobby_name : String, error : int) -> void:
	print("Failed to create lobby ", lobby_name, ". error: ", error)
	
	authed = true
	
	match(error):
		ENUMS.LOBBY_CREATION_ERROR.LOBBY_ALREADY_EXISTS:
			$CanvasLayer/Error.text = ("A lobby with the name "+lobby_name+" already exists.")
			authed = false
			show_objects()
		ENUMS.LOBBY_CREATION_ERROR.NAME_TOO_SHORT:
			$CanvasLayer/Error.text = (lobby_name+" is too short.")
			authed = false
			show_objects()
		ENUMS.LOBBY_CREATION_ERROR.NAME_TOO_LONG:
			$CanvasLayer/Error.text = (lobby_name+" is too long.")
			authed = false
			show_objects()
		ENUMS.LOBBY_CREATION_ERROR.PASSWORD_TOO_LONG:
			$CanvasLayer/Error.text = ("The password for "+lobby_name+" is too long.")
			authed = false
			show_objects()
		ENUMS.LOBBY_CREATION_ERROR.TAGS_TOO_LARGE:
			$CanvasLayer/Error.text = ("The tags have exceeded the 2048 byte limit.")
			authed = false
			show_objects()
		ENUMS.LOBBY_CREATION_ERROR.DATA_TOO_LARGE:
			$CanvasLayer/Error.text = ("The data have exceeded the 2048 byte limit.")
			authed = false
			show_objects()
		ENUMS.LOBBY_CREATION_ERROR.ON_COOLDOWN:
			$CanvasLayer/Error.text = ("Please wait a few seconds before creating another lobby.")
			authed = false
			show_objects()

func lobby_joined(lobby_name : String) -> void:
	
	print("Lobby joined ", lobby_name)

func lobby_join_failed(lobby_name : String, error : int) -> void:
	print("Lobby join failed ", lobby_name, ". error: ", error)
	
	authed = true
	
	match(error):
		ENUMS.LOBBY_JOIN_ERROR.INCORRECT_PASSWORD:
			$CanvasLayer/Error.text = "INCORRECT PASSWORD!"
			if $CanvasLayer/create.visible:
				print("Ask to enter password!")
			authed = false
		ENUMS.LOBBY_JOIN_ERROR.LOBBY_DOES_NOT_EXIST:
			$CanvasLayer/Error.text = "LOBBY DOES NOT EXIST!"
			authed = false
		ENUMS.LOBBY_JOIN_ERROR.LOBBY_IS_FULL:
			$CanvasLayer/Error.text = "LOBBY IS FULL!"
			authed = false
		ENUMS.LOBBY_JOIN_ERROR.LOBBY_IS_CLOSED:
			$CanvasLayer/Error.text = "LOBBY IS CLOSED!"
			authed = false

func lobbies_recived(lobbies : Array):
	print(lobbies)
	
	for lobby in lobbies:
		var instace = lobby_thing.instantiate()
		instace.lobby_name = lobby["Name"]
		instace.password_needed = lobby["HasPassword"]
		instace.players = lobby["PlayerCount"]
		$tower/lobbys.add_child(instace)
	if $tower/lobbys.get_children().size() == 0:
		$tower/Label.show()

#for child in $"Panel/ScrollContainer/Lobbie title + lobbies/lobbies".get_children():
	#	child.queue_free()
	#get_lobbies()


func get_lobbies():
	GDSync.get_public_lobbies()



func _on_refresh_sign_pressed():
	$tower/Label.hide()
	for child in $tower/lobbys.get_children():
		child.queue_free()
	get_lobbies()


func _on_create_sign_pressed():
	$CanvasLayer/create.show()



func _on_button_pressed():
	GDSync.lobby_create("TEST_LOBBY","",true, 4)
	$tower/Label.hide()
	for child in $tower/lobbys.get_children():
		child.queue_free()
	get_lobbies()
	GDSync.lobby_join("TEST_LOBBY")
	await get_tree().create_timer(1).timeout
	$BaseLoby.show()
	$tower.hide()
	$TileMap.hide()
	$CanvasLayer.hide()
	$RefreshSign.hide()
	$Button.hide()
	$CreateSign.hide()
	$Camera2D.enabled = false


func _on_submit_pressed():
	if $"CanvasLayer/create/fields/use_password?".button_pressed == false:
		GDSync.lobby_create($"CanvasLayer/create/fields/Lobby name".text,"",$"CanvasLayer/create/fields/public?".button_pressed, 4)
	else:
		print("HUh", " create using ", $CanvasLayer/create/fields/Password.text)
		GDSync.lobby_create($"CanvasLayer/create/fields/Lobby name".text,$CanvasLayer/create/fields/Password.text,$"CanvasLayer/create/fields/public?".button_pressed, 4)
	$tower/Label.hide()
	for child in $tower/lobbys.get_children():
		child.queue_free()
	get_lobbies()
	if $"CanvasLayer/create/fields/use_password?".button_pressed == false:
		GDSync.lobby_join($"CanvasLayer/create/fields/Lobby name".text)
		authed = true
	else:
		print("HUh", " join using ", $CanvasLayer/create/fields/Password.text)
		GDSync.lobby_join($"CanvasLayer/create/fields/Lobby name".text,$CanvasLayer/create/fields/Password.text)
		$CanvasLayer/create.hide()
		authed = true
	$CanvasLayer/create.hide()
	await get_tree().create_timer(1).timeout
	if authed:
		Online.lobby = $"CanvasLayer/create/fields/Lobby name".text
		$BaseLoby.show()
		$tower.hide()
		$TileMap.hide()
		$CanvasLayer.hide()
		$RefreshSign.hide()
		$Button.hide()
		$CreateSign.hide()
		$Camera2D.enabled = false
		authed = false

func _process(delta):
	if $"CanvasLayer/create/fields/public?".button_pressed == false:
		$"CanvasLayer/create/fields/use_password?".button_pressed = false
	
	if $"CanvasLayer/create/fields/use_password?".button_pressed == true:
		$CanvasLayer/create/fields/Password.show()
	if $"CanvasLayer/create/fields/use_password?".button_pressed == false:
		$CanvasLayer/create/fields/Password.hide()


func _on_byname_pressed():
	if not $CanvasLayer/byname/name.visible:
		$CanvasLayer/byname/name.show()
	else:
		$CanvasLayer/byname/name.show()
		$CanvasLayer/create.hide()
		GDSync.lobby_join($CanvasLayer/byname/name.text)
		authed = true
		print("pre: ",authed)
		await get_tree().create_timer(1.5).timeout
		print("mid: ",authed)
		print($CanvasLayer/Error.text)
		if authed:
			print("after: ",authed)
			$BaseLoby.show()
			$tower.hide()
			$TileMap.hide()
			$CanvasLayer.hide()
			$RefreshSign.hide()
			$Button.hide()
			$CreateSign.hide()
			$Camera2D.enabled = false
			authed = false
