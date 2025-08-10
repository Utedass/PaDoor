extends Node2D

@onready var durationTimer: Timer = $Duration
@onready var DashGhost = preload("res://objects/dash_ghost.tscn")

var sprite : AnimatedSprite2D

func startDash(sprite: AnimatedSprite2D, duration: float):
	self.sprite = sprite
	durationTimer.wait_time = duration
	durationTimer.start()
	instanceGhost()

func instanceGhost():
	var ghostInstance : Sprite2D = DashGhost.instantiate()
	get_tree().get_root().add_child(ghostInstance)
	ghostInstance.global_position = global_position
	ghostInstance.texture = sprite.get_sprite_frames().get_frame_texture(sprite.animation, sprite.get_frame())
	ghostInstance.flip_h = sprite.flip_h
	ghostInstance.scale = sprite.scale
	

func isDashing():
	return !durationTimer.is_stopped()
