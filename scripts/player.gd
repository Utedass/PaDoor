extends CharacterBody2D

@export var speed := 200

func _physics_process(delta):
	var dir = Vector2.ZERO
	dir.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	dir.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	velocity = dir.normalized() * speed
	move_and_slide()

func teleport(position: Vector2):
	var camera:Camera2D = $Camera2D
	global_position = position
	camera.reset_smoothing()
