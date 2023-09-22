extends Camera3D
var chosen_gun
# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var chosen_gun = get_node("gun_choosing_menu").chosen_gun
	if chosen_gun == "Sniper":
		if Input.is_action_pressed("zoom"):
			fov = 35
			$Sniper.visible = false
			$scope.visible = true
		else:
			fov = 90
			$Sniper.visible = true
			$scope.visible = false
	else:
		$scope.visible = false
	pass
