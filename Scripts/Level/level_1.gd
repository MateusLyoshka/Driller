extends Node2D

@onready var terrain: TileMapLayer = $Terrains/Terrain
@onready var player: CharacterBody2D = $Player

var tile_health = {}
var can_break:bool = true
var collisions:float
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var mouse_global_pos = get_global_mouse_position()
	if Input.is_action_pressed("Click") and can_break and player.is_mouse_in_player_area():
		can_break = false
		$BlockBreak.start()
		var clicked_block = terrain.local_to_map(mouse_global_pos)
		var block_data = terrain.get_cell_tile_data(clicked_block)
		if block_data and not block_data.get_custom_data("Unbreakable"):
			var block_life = block_data.get_custom_data("Life")
			if not tile_health.has(clicked_block):
				tile_health[clicked_block] = block_life
			if tile_health[clicked_block] <= 0:
				terrain.erase_cell(clicked_block)
				tile_health.erase(clicked_block)
			else:
				#print(tile_health)
				tile_health[clicked_block] -= 1
	
func _on_block_break_timeout() -> void:
	can_break = true
	
