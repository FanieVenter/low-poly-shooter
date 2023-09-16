extends Camera3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("zoom"):
		fov = 35
		$Sniper.visible = false
		$scope.visible = true
	else:
		fov = 90
		$Sniper.visible = true
		$scope.visible = false
	pass
