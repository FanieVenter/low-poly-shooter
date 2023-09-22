extends Node
@onready var crosshair = $crosshair
var peer = ENetMultiplayerPeer.new()
var Ip
var port
var chosen_gun
# Called when the node enters the scene tree for the first time.
func _ready():
	var Ip = "localhost"
	var port = "20"
# By default, these expressions are interchangeable.
	multiplayer # Get the MultiplayerAPI object configured for this node.
	get_tree().get_multiplayer() # Get the default MultiplayerAPI object.
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	crosshair.visible = false
# Called every fDrame. 'delta' is the elapsed time since the previous frame.





func _on_join_pressed():
	Ip = str($Menu/IpAddress.text)
	port = int($Menu/Port.text)
	peer.create_client(Ip, port)
	multiplayer.multiplayer_peer = peer
	print("Joining Server=",Ip,":",port)
	$Menu.visible = false
	$Background.visible = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	crosshair.visible = true
	


func _on_host_pressed():
	var port = str($Menu/Port.text).to_int()
	peer.create_server(port)
	multiplayer.multiplayer_peer = peer
	$Menu.visible = false
	$Background.visible = false
	print("Hosting Server:",port)
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	multiplayer.peer_connected.connect(func(id): add_player_character(id))
	add_player_character()
	crosshair.visible = true
	
	
func add_player_character(id=1):
	var character = preload("res://Scenes/Player/player.tscn").instantiate()
	character.name = str(id)
	#add_child(character)
	
