@tool
class_name DualGridTileMapLayer
extends TileMapLayer

var display_grid: TileMapLayer = TileMapLayer.new()
var offset: Vector2i
# 用于匹配图块的字典
var tile_matching_list = {
	# 格式说明：键顺序 [左上, 右上, 左下, 右下]
	[true,  true,  true,  true]:  { "atlas_coord": Vector2i(4, 0), "alt_id": 0 },
	
	[false, true,  true,  true]:  { "atlas_coord": Vector2i(2, 0), "alt_id": 2 },
	[true,  false, true,  true]:   { "atlas_coord": Vector2i(2, 0), "alt_id": 3 },
	[true,  true,  false, true]:  { "atlas_coord": Vector2i(2, 0), "alt_id": 0 },
	[true,  true,  true,  false]: { "atlas_coord": Vector2i(2, 0), "alt_id": 1 },
	
	[false, false, true,  true]:  { "atlas_coord": Vector2i(1, 0), "alt_id": 1 },
	[false, true,  false, true]:  { "atlas_coord": Vector2i(1, 0), "alt_id": 3 },
	[false, true,  true,  false]: { "atlas_coord": Vector2i(3, 0), "alt_id": 1 },
	[true,  false, false, true]:  { "atlas_coord": Vector2i(3, 0), "alt_id": 0 },
	[true,  false, true,  false]: { "atlas_coord": Vector2i(1, 0), "alt_id": 2 },
	
	[true,  true,  false, false]: { "atlas_coord": Vector2i(1, 0), "alt_id": 0 },
	
	[true,  false, false, false]: { "atlas_coord": Vector2i(0, 0), "alt_id": 0 },
	[false, true,  false, false]: { "atlas_coord": Vector2i(0, 0), "alt_id": 1 },
	[false, false, true,  false]: { "atlas_coord": Vector2i(0, 0), "alt_id": 2 },
	[false, false, false, true]:  { "atlas_coord": Vector2i(0, 0), "alt_id": 3 },
	
	[false, false, false, false]: { "atlas_coord": Vector2i(-1, -1), "alt_id": -1 }
}

const NEIGHBOURS = [Vector2i(1, 1), Vector2i(1, 0), Vector2i(0, 1), Vector2i(0, 0)]

func _enter_tree() -> void:
	# 初始化显示网格
	add_child(display_grid)
	display_grid.tile_set = tile_set
	offset = tile_set.tile_size / 2
	display_grid.position = offset
	
	# 遍历已使用单元格
	for cell in get_used_cells():
		set_tile(cell)

func  _process(delta: float) -> void:
	# 用于编辑器预览
	if Engine.is_editor_hint():
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) or Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
			display_grid.clear()
			for cell in get_used_cells():
				set_tile(cell)

# 绘制图块
func set_tile(wor_tile_coord: Vector2i):
	if !Engine.is_editor_hint():
		set_cell(wor_tile_coord, 0, Vector2(5,0))
	var dis_tile_coords = get_display_tile_coord(wor_tile_coord)
	for coord in dis_tile_coords:
		var tile_data = calculate_display_tile(coord)
		display_grid.set_cell(coord, 0, tile_data.atlas_coord, tile_data.alt_id)

# 擦除图块
func erase_tile(wor_tile_coord: Vector2i):
	erase_cell(wor_tile_coord)
	var dis_tile_coords = get_display_tile_coord(wor_tile_coord)
	for coord in dis_tile_coords:
		var tile_data = calculate_display_tile(coord)
		display_grid.set_cell(coord, 0, tile_data.atlas_coord, tile_data.alt_id)

# 获取世界图块对应的绘制图块坐标
func get_display_tile_coord(wor_tile_coord: Vector2i) -> Array[Vector2i]:
	var top_l = wor_tile_coord - NEIGHBOURS[0]
	var top_r = wor_tile_coord - NEIGHBOURS[2]
	var bot_l = wor_tile_coord - NEIGHBOURS[1]
	var bot_r = wor_tile_coord - NEIGHBOURS[3]
	return [top_l, top_r, bot_l, bot_r]

# 匹配绘制图块
func calculate_display_tile(dis_tile_coord: Vector2i) -> Dictionary:
	var top_l = is_world_tile_exist(dis_tile_coord + NEIGHBOURS[3])
	var top_r = is_world_tile_exist(dis_tile_coord + NEIGHBOURS[1])
	var bot_l = is_world_tile_exist(dis_tile_coord + NEIGHBOURS[2])
	var bot_r = is_world_tile_exist(dis_tile_coord + NEIGHBOURS[0])
	
	return tile_matching_list[[top_l, top_r, bot_l, bot_r]]

# 检测世界图块存在
func is_world_tile_exist(wor_tile_coord: Vector2i) -> bool:
	return get_cell_source_id(wor_tile_coord) != -1
