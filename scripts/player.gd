extends CharacterBody2D

@export var speed := 100

@export var dashDuration := 0.2
@export var dashSpeed := 300

@onready
var animation: AnimatedSprite2D = $AnimatedSprite2D

@onready
var dash = $Dash

enum AnimationDirection { EAST, WEST, NORTH, SOUTH }
var lastDirection: AnimationDirection = AnimationDirection.SOUTH

func _physics_process(delta):
	if Input.is_action_just_pressed("dash"):
		print_debug("DASHING!!")
		dash.startDash($AnimatedSprite2D, dashDuration)
	
	var chosenSpeed = speed
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
