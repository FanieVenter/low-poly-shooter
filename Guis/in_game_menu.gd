extends Control
var return_pressed = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	visible = true
	pass # Replace with function body.


	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("Escape"):
		visible = !visible;
		return_pressed = 0
	if visible == false:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	if visible == true:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	return_pressed + 0.5
	
func _on_quit_pressed():
	get_tree().quit()


func _on_return_to_game_pressed():
	visible = false
	
	


func _on_leave_game_pressed():
	visible = false
	multiplayer.multiplayer_peer = null
	print("Left Game")

