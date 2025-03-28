extends Node2D

#This script is not used for now. Eventually maybe, ittl become used as a level editor of some sort.

@onready var tile_map: TileMapLayer = $TileMap
@onready var ground_map: TileMapLayer = $daworl
var ground_layer = 1
var slot = 0
var can_place_tile_data = "can_place"

#next tile slot
func _input(event):
	if Input.is_action_just_pressed("next"):
		slot = slot + 1
#previous tile slot
	if Input.is_action_just_pressed("prev"):
		slot = slot - 1
#if clicked place tile on map
	if Input.is_action_pressed("m1"):
		var mouse_pos : Vector2 = get_global_mouse_position()
		var tile_mouse_pos : Vector2i = tile_map.local_to_map(mouse_pos)
		#print(tile_mouse_pos)
		var tile_data : TileData = ground_map.get_cell_tile_data(tile_mouse_pos)
		var source_id : int = slot
		var atlas_coord : Vector2i = Vector2i(0,0)
		#checks if you can place the tile. Can_place_tile is a variable set inside the tilemapLayer
		if tile_data:
			var can_place_tile = tile_data.get_custom_data(can_place_tile_data)
			if can_place_tile:
				tile_map.set_cell(tile_mouse_pos, source_id, atlas_coord)
			else:
				print("cannot place tile!")
		else:
			print("no tilemap found!")
