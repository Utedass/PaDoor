extends TileMapLayer

@export var tile_source_id: int = 0  # Which TileSet resource to use
@export var available_tiles: Array[Vector2i] = []  # tile coords from your tileset
@export var map_width: int = 20
@export var map_height: int = 20

func _ready():
	randomize()
	generate_random_map()

func generate_random_map():
	clear()  # remove all existing tiles
	for x in range(map_width):
		for y in range(map_height):
			if randi() % 4 == 0: # 25% chance to place tile
				var tile_id = available_tiles[randi() % available_tiles.size()]
				set_cell(Vector2i(x, y), tile_source_id, tile_id)
