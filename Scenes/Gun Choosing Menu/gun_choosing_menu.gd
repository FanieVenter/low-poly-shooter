extends Control

var chosen_gun

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	pass


func _on_sniper_pressed():
	chosen_gun = "sniper"
	pass # Replace with function body.


func _on_pistol_pressed():
	chosen_gun = "pistol"
	
	pass # Replace with function body.
