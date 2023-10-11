extends Camera3D
var chosen_gun
var sniper_zoomed = Vector3(0,-0.2,-0.509) 
@onready var sniper_anim = $Sniper/AnimationPlayer
# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !self.current:
		self.current = true
	var chosen_gun = get_node("gun_choosing_menu").chosen_gun
	if chosen_gun == "Sniper":
		if !sniper_anim.is_playing():
			if Input.is_action_just_pressed("zoom"):
				sniper_anim.play("zoom_in")
				get_tree().create_timer(2).timeout
				fov = 35
			if !Input.is_action_pressed("zoom"):
				if $Sniper.position == sniper_zoomed:
						sniper_anim.play("zoom_out")
						get_tree().create_timer(2).timeout
						fov = 90
					
	else:
		pass
	pass
