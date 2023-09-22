extends CharacterBody3D
var shoot_distance
#@onready var chosen_gun = $gun_choosing_menu
@onready var shootRay = $Head/Camera3d/pistol/RayCast3d as RayCast3D
@onready var gunRay = $Head/Camera3d/Sniper/RayCast3D as RayCast3D
@onready var Cam = $Head/Camera3d as Camera3D
@export var _bullet_scene : PackedScene
@onready var synchronizer = $MultiplayerSynchronizer
var mouseSensibility = 1200
var mouse_relative_x = 0
var mouse_relative_y = 0
var SPEED = 5.0
const JUMP_VELOCITY = 5
var mouse_visible = true
var chosen_gun


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var sprint_duration = 0
var anim
var sniper
func _ready():
	
	#Captures mouse and stops rgun from hitting yourself
	synchronizer.set_multiplayer_authority(str(name).to_int())
	Cam.current = synchronizer.is_multiplayer_authority()
	shootRay.add_exception(self)
	gunRay.add_exception(self)
	
func _physics_process(delta):
	
		
	
	var chosen_gun = get_node("Head/Camera3d/gun_choosing_menu").chosen_gun
	if chosen_gun == "Pistol":
		shoot_distance = 10
		$Head/Camera3d/pistol.visible = true
	if chosen_gun == null:
		shoot_distance = 1
	if chosen_gun == "Sniper":
		shoot_distance = 35
		$Head/Camera3d/Sniper.visible = true
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
	# Handle Shooting
	if Input.is_action_just_pressed("Shoot"):
		shoot()
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
		$Head/Camera3d.rotation.x -= event.relative.y / mouseSensibility
		$Head/Camera3d.rotation.x = clamp($Head/Camera3d.rotation.x, deg_to_rad(-90), deg_to_rad(90) )
		mouse_relative_x = clamp(event.relative.x, -50, 50)
		mouse_relative_y = clamp(event.relative.y, -50, 10)

func shoot():
	if not shootRay.is_colliding():
		return
	if shootRay.is_colliding():
		var origin = shootRay.global_transform.origin
		var collision_point = shootRay.get_collision_point()
		var distance = origin.distance_to(collision_point)
		var bulletInst = _bullet_scene.instantiate() as Node3D
		var origin_gun = gunRay.global_transform.origin
		var gun_collision_point = gunRay.get_collision_point()
		var gun_distance = origin_gun.distance_to(gun_collision_point)
		if distance < shoot_distance:
			if gun_distance > 0.1:
				if Input.is_action_pressed("sprint") != true:
					bulletInst.set_as_top_level(true)
					get_parent().add_child(bulletInst)
					bulletInst.global_transform.origin = shootRay.get_collision_point() as Vector3
					bulletInst.look_at((shootRay.get_collision_point()+shootRay.get_collision_normal()),Vector3.BACK)
			
