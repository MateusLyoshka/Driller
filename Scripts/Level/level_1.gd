extends Node2D

@onready var terrain: TileMapLayer = $Terrains/Terrain
@onready var player: CharacterBody2D = $Player
@onready var raycasts: Node2D = $Player/Raycasts

var tile_health = {}
var can_break:bool = true
var collisions:float
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var mouse_global_pos = get_global_mouse_position()
	if Input.is_action_pressed("Click") and can_break:
		can_break = false
		$BlockBreak.start()
		var clicked_cell = terrain.local_to_map(mouse_global_pos)
		print("mouse: ",clicked_cell)
		var near_breakable_block = verify_collision(clicked_cell)
		if near_breakable_block:
			var block_life = near_breakable_block.get_custom_data("Life")
			if not tile_health.has(clicked_cell):
				tile_health[clicked_cell] = block_life
			if tile_health[clicked_cell] <= 0:
				terrain.erase_cell(clicked_cell)
				tile_health.erase(clicked_cell)
			else:
				#print(tile_health)
				tile_health[clicked_cell] -= 1

func verify_collision(clicked_block:Vector2i) -> TileData:
	var raycast_nodes = raycasts.get_children()

	for i in 8:
		var raycast:RayCast2D = raycast_nodes[i]
		raycast.force_raycast_update()
		if raycast.is_colliding():
			var raycast_clicked_block = terrain.local_to_map(raycast.get_collision_point())
			print(raycast_clicked_block)
			print(raycast.name)
			var cell_data:TileData = terrain.get_cell_tile_data(raycast_clicked_block)
			if cell_data and raycast_clicked_block == clicked_block and not cell_data.get_custom_data("Unbreakable"):
				print("Coord block: ", raycast_clicked_block)
				print("Coord mouse: ", clicked_block)
				print("Cell data: ", cell_data)
				return cell_data
	return null
	
	
func _on_block_break_timeout() -> void:
	can_break = true
