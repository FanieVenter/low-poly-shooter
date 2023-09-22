extends Node3D

@onready var crosshair = $crosshair
var chosen_gun
# Called when the node enters the scene tree for the first time.
func _ready():
	crosshair.visible = true
	#pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	var chosen_gun = get_node("gun_choosing_menu").chosen_gun
	
	#if $gun_choosing_menu.visible == false:
		#	crosshair.visible = true
	#if chosen_gun != null:
		#$gun_choosing_menu.visible = false
		#print(chosen_gun)
	
