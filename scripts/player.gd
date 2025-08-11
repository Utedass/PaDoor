extends CharacterBody2D

@export var speed := 100
@export var walkSpeed := speed / 2 
var is_walking := false


@export var dashDuration := 0.2
@export var dashSpeed := 300

@onready
var animation: AnimatedSprite2D = $AnimatedSprite2D

@onready
var dash = $Dash

enum AnimationDirection { EAST, WEST, NORTH, SOUTH }
var lastDirection: AnimationDirection = AnimationDirection.SOUTH
# Jumpest
var jump_time := 0.0
var jump_duration := 0.5 
var is_jumping := false

func start_jump():
	is_jumping = true
	jump_time = 0.0
	print_debug("test jump")

	
func _process(delta):
	if is_jumping:
		jump_time += delta
		var t = jump_time / jump_duration
		if t > 1.0:
			t = 1.0
			is_jumping = false
		var scale_factor = 1 + 0.3 * 4 * t * (1 - t)
		animation.scale = Vector2(scale_factor *2.3, scale_factor) # Det funkar inte jättebra
	else:
		animation.scale = Vector2(1, 1)

#End jumptest

func _input(event):
	if Input.is_action_just_pressed("walk_toggle"):
		is_walking = !is_walking
		print_debug("test toggle",  is_walking)
	if Input.is_action_just_pressed("start_jump"):
		start_jump()
		print_debug("test jump press")
		
func _physics_process(delta):
	if Input.is_action_just_pressed("dash"):
		print_debug("DASHING!!")
		dash.startDash($AnimatedSprite2D, dashDuration)
	
	var chosenSpeed = walkSpeed if is_walking else speed
	if dash.isDashing():
		chosenSpeed = dashSpeed
	
	var dir = Vector2.ZERO
	dir.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	dir.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	velocity = dir.normalized() * chosenSpeed
	velocity.y /= 2
	
	if dir.x > 0:
		animation.flip_h = false
	elif dir.x < 0:
		animation.flip_h = true
	
	if dir.x == 0 and dir.y == 0:
		match lastDirection:
			AnimationDirection.NORTH:
				animation.play("idleNorth")
			AnimationDirection.SOUTH:
				animation.play("idleSouth")
			_:
				animation.play("idleEast")
	elif dir.y < -abs(dir.x):
		animation.play("runNorth")
		lastDirection = AnimationDirection.NORTH
	elif dir.y > abs(dir.x):
		animation.play("runSouth")
		lastDirection = AnimationDirection.SOUTH
	else:
		animation.play("runEast")
		lastDirection = AnimationDirection.EAST
	move_and_slide()

func teleport(position: Vector2):
	var camera:Camera2D = $Camera2D
	global_position = position
	camera.reset_smoothing()
