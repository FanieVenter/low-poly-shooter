extends CharacterBody3D
var shoot_distance
var health
var hit_player
#@onready var chosen_gun = $gun_choosing_menu
@onready var gun_barrel = $Camera3d/Sniper/RayCast3D
@onready var Cam = $Camera3d as Camera3D
var bullet = load("res://Scenes/Bullet/Bullet.tscn")
var instance
@onready var Sniper = $Camera3d/Sniper
@onready var synchronizer = $MultiplayerSynchronizer
@onready var sniper_anim = $Camera3d/Sniper/AnimationPlayer
var mouseSensibility = 1200
var mouse_relative_x = 0
var mouse_relative_y = 0
var SPEED = 5.0
const JUMP_VELOCITY = 5
var mouse_visible = true
var chosen_gun
var sniper_cooldown = 0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var sprint_duration = 0
var anim
var sniper
func _ready():
	health = 50
	#Captures mouse and stops rgun from hitting yourself
	synchronizer.set_multiplayer_authority(str(name).to_int())
	Cam.current = synchronizer.is_multiplayer_authority()
	
func _physics_process(delta):
	
	if health < 1:
		get_tree().quit()
	if health < 100:
		if hit_player == false:
			health + 4
		get_tree().create_timer(1).timeout
	if Input.is_action_pressed("Shoot"):
		if sniper_cooldown == 0:
			if !sniper_anim.is_playing():
				if Sniper.position == Vector3(0,-0.2,-0.509):
					sniper_anim.play("zoom_shoot")
				if Sniper.position == Vector3(0.375,-0.357,-0.916):
					sniper_anim.play("shoot")
				instance = bullet.instantiate()
				instance.position = gun_barrel.global_position
				instance.transform.basis = $Camera3d.global_transform.basis
				get_parent().add_child(instance)
				sniper_cooldown = 1
				await get_tree().create_timer(3.0).timeout
				sniper_cooldown = 0
				
		
	
	var chosen_gun = get_node("Camera3d/gun_choosing_menu").chosen_gun
	if chosen_gun == "Pistol":
		shoot_distance = 10
		$Camera3d/pistol.visible = true
	if chosen_gun == null:
		shoot_distance = 1
	if chosen_gun == "Sniper":
		shoot_distance = 35
		$Camera3d/Sniper.visible = true
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
	if Input.is_action_just_pressed("Escape"):
		mouse_visible = !mouse_visible;
	# Handle Jump.
	if (mouse_visible):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	else:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY 
	if Input.is_action_pressed("sprint"):
		if !Input.is_action_pressed("zoom"):
			
			SPEED = 8.0
				
				
				
	else:
		
		SPEED = 6.0
		
	
	# Get the input direction and handle the movement/deceleration.
	var input_dir = Input.get_vector("moveLeft", "moveRight", "moveUp", "moveDown")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
	
	

func _input(event):
	
	
	if event is InputEventMouseMotion:
		rotation.y -= event.relative.x / mouseSensibility
		$Camera3d.rotation.x -= event.relative.y / mouseSensibility
		$Camera3d.rotation.x = clamp($Camera3d.rotation.x, deg_to_rad(-90), deg_to_rad(90) )
		mouse_relative_x = clamp(event.relative.x, -50, 50)
		mouse_relative_y = clamp(event.relative.y, -50, 10)
func hit():
	health - 50
	hit_player = true
	get_tree().create_timer(10).timeout
	hit_player = false
