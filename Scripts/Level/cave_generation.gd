extends Node

#Noise var
var fast_noise := FastNoiseLite.new()
@onready var terrain_tile: TileMapLayer = $"../../Terrain"
@onready var background_tile: TileMapLayer = $"../../CavesBackground"

#Cave vars
var cave_tile: TileMapLayer
var cave_set: int = 0
var cave_id: int = 0  

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	cave_tile = get_parent() as TileMapLayer
	fast_noise.seed = randi()
	fast_noise.noise_type = FastNoiseLite.TYPE_PERLIN
	fast_noise.fractal_octaves = 2
	fast_noise.frequency = 0.08
	_generate_cave()

func _generate_cave():

	for x in 100:
		for y in range(3,50,1):
			var coord = Vector2i(x,y)
			var noise := fast_noise.get_noise_2d(x,y)
			if noise > 0.14:
				cave_tile.set_cells_terrain_connect([coord], cave_set, cave_set, 0)
			else:
				var atlas = Vector2i(6, 1)
				terrain_tile.set_cell(coord, 0, Vector2i(6,1),0)
			background_tile.set_cell(coord, 0, Vector2i(0,0),0)

func _is_cave():
	pass

func _is_cave_floor():
	pass

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Restart"):
		get_tree().reload_current_scene()
