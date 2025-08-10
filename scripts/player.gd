extends CharacterBody2D

@export var speed := 100

@onready
var animation: AnimatedSprite2D = $AnimatedSprite2D

enum AnimationDirection { EAST, WEST, NORTH, SOUTH }
var lastDirection: AnimationDirection = AnimationDirection.SOUTH

func _physics_process(delta):
	var dir = Vector2.ZERO
	dir.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	dir.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	velocity = dir.normalized() * speed
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
