extends Node

var player: CharacterBody2D
var current_map: Node2D

func _ready():
	player = $"../Player"
	load_map("map_town", "start")

func load_map(scene_name: String, entry_id: String):
	if scene_name == "":
		return

	var full_scene_path = "res://maps/" + scene_name + ".tscn"

	var new_map = load(full_scene_path).instantiate()
	add_child(new_map)

	# Wait a frame so nodes are ready
	await get_tree().process_frame
	var target_found: bool = false
	for door in new_map.get_tree().get_nodes_in_group("doors"):
		door.connect("door_triggered", _on_door_triggered)
		if door.door_id == entry_id:
			target_found = true
			player.global_position = door.global_position
	if not target_found:
		return
	if current_map:
		current_map.queue_free()
	current_map = new_map

func _on_door_triggered(scene_name, target_id):
	load_map(scene_name, target_id)
