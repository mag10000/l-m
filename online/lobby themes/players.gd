extends Node2D

@export var player_scene : PackedScene
@export var player_scene_2 : PackedScene

var do_ping_loop = true
var started = false

func _ready():
	GDSync.client_joined.connect(client_joined)
	GDSync.client_left.connect(client_left)

func client_joined(cliend_id : int) -> void:
	print("client joined ", cliend_id)
	
	if cliend_id == GDSync.get_client_id():
		print('Own id ', cliend_id)
	
	var player : Node2D = player_scene.instantiate()
	player._name = str(cliend_id)
	player.name = str(cliend_id)
	GDSync.set_gdsync_owner(player, cliend_id)
	var player2 = player_scene_2.instantiate()
	player._name = str(cliend_id)
	player.name = str(cliend_id)
	GDSync.set_gdsync_owner(player, cliend_id)
	self.position.x += 10
	ping_loop(cliend_id)
	add_child(player)
	$"../Players2".position.x += 10
	$"../Players2".add_child(player2)

func ping_loop(cliend_id):
	if do_ping_loop:
		var ping : float = await GDSync.get_client_ping(cliend_id)
		if ping != null:
			print(str(ping))
			if ping:
				$"../CanvasLayer/Label".text = "PING: " + str(ping)
		await get_tree().create_timer(0.01).timeout
		ping_loop(cliend_id)
	else:
		$"../CanvasLayer/Label".text = "ERROR could'nt connect."
		pass


func client_left(cliend_id : int) -> void:
	print("Client left", cliend_id)
	var player : Node2D = get_node_or_null(str(cliend_id))
	if player != null:
		player.queue_free()


func _on_button_pressed():
	get_tree().change_scene_to_file("res://online/levels/world_online.tscn")
