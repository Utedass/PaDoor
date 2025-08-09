extends Node

var player
var current_map

func _ready():
	player = $"../Player"
	load_map("res://maps/map_town.tscn", "start")

func load_map(scene_path: String, entry_id: String):
	if current_map:
		current_map.queue_free()

	current_map = load(scene_path).instantiate()
	#current_map = load("res://maps/map_forest.tscn").instantiate()
	#current_map = load("res://maps/map_town.tscn").instantiate()
	add_child(current_map)

	# Wait a frame so nodes are ready
	await get_tree().process_frame

	for door in current_map.get_tree().get_nodes_in_group("doors"):
		door.connect("door_triggered", _on_door_triggered)
		if door.door_id == entry_id:
			player.global_position = door.global_position

func _on_door_triggered(scene_path, target_id):
	load_map(scene_path, target_id)
