extends Node

var tile_map: TileMapLayer
var tile_coord:Vector2i = Vector2i(0,0)
var width := 100
var height := 100
var cave_data := []

var terrain_set: int = 0 # ID do terrain set no TileSet
var terrain_id: int = 0  # Tipo de terreno dentro do terrain set (ex: parede = 0)
var fast_noise := FastNoiseLite.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	tile_map = get_parent() as TileMapLayer
	_generate_cave()
	#_update_tilemap()

func _generate_cave():
	var coord = []
	for x in 30:
		for y in 30:
			var noise := fast_noise.get_noise_2d(x,y)
			if noise < 0.14:
				coord.append(Vector2i(x,y))

	tile_map.set_cells_terrain_connect(coord, terrain_set, terrain_set, 0)

#func _update_tilemap():
	#var terrain_positions = []
#
	#for y in height:
		#for x in width:
			#var pos = Vector2i(x, y)
			#if cave_data[y][x] == 1:
				#terrain_positions.append(pos)
	#
	#tile_map.set_cells_terrain_connect(terrain_positions, terrain_set, terrain_id, 0)
