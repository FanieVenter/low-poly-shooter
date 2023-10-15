extends Node3D
@export var PlayerScene : PackedScene
@onready var crosshair = $crosshair
var chosen_gun

var index
# Called when the node enters the scene tree for the first time.
func _ready():
	var index = 0
	
	for i in GameManager.Players:
		var currentPlayer = PlayerScene.instantiate()
		add_child(currentPlayer)
		for spawn in get_tree().get_nodes_in_group("PlayerSpawnPoint"):
			if spawn.name == str(index):
				print(index)
				index += 1
				currentPlayer.global_position = spawn.global_position
	
	crosshair.visible = true
	

	#pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	
	
	pass
