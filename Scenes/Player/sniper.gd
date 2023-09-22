extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	var anim = get_node("AnimationPlayer")
	anim.play("Running_stop")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("sprint"):
		var anim = get_node("AnimationPlayer")
		
		if(anim.current_animation != "Running"):
			anim.play("Running")
			
		
		
	if Input.is_action_just_released("sprint"):
		var anim = get_node("AnimationPlayer")
		anim.play("Running_stop")
		
