extends Area2D

@export var door_id: String
@export var target_scene: String
@export var target_door_id: String
@export var locked: bool = false
@export var key_item: String = ""

signal door_triggered(scene_path, target_id)

var active: bool

func _ready():
	add_to_group("doors")
	await get_tree().create_timer(0.2).timeout
	connect("body_entered", _on_body_entered)
	active = true

func _on_body_entered(body):
	if active and body.name == "Player" and not locked:
		emit_signal("door_triggered", target_scene, target_door_id)
