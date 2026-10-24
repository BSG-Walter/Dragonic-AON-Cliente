/// @description Returns the id of a tile at a given depth and position.
/// @param depth The depth of the tile to be found.
/// @param x The x position to check.
/// @param y The y position to check.
/// @returns 
function tile_layer_find(argument0, argument1, argument2) {

	var __depth = argument0;
	var __x = argument1;
	var __y = argument2;

	// Inicia el caché espacial para la sala actual si cambió de room
	if (!variable_global_exists("__tile_cached_room") || global.__tile_cached_room != room) {
		if (variable_global_exists("__tile_depth_map") && ds_exists(global.__tile_depth_map, ds_type_map)) {
			ds_map_destroy(global.__tile_depth_map);
		}
		global.__tile_cached_room = room;
		global.__tile_depth_map = ds_map_create();
		
		var __all_layers = layer_get_all();
		var __num_layers = array_length(__all_layers);
		
		for (var __i = 0; __i < __num_layers; __i++) {
			var __lay = __all_layers[__i];
			var __d = layer_get_depth(__lay);
			var __elements = layer_get_all_elements(__lay);
			var __num_elements = array_length(__elements);
			
			var __tiles_in_layer = [];
			var __t_idx = 0;
			
			for (var __j = 0; __j < __num_elements; __j++) {
				var __el = __elements[__j];
				if (layer_get_element_type(__el) == layerelementtype_tile) {
					var __tx = layer_tile_get_x(__el);
					var __ty = layer_tile_get_y(__el);
					var __xs = layer_tile_get_xscale(__el);
					var __ys = layer_tile_get_yscale(__el);
					var __reg = layer_tile_get_region(__el);
					
					var __x1 = __tx;
					var __y1 = __ty;
					var __x2 = __tx + (__xs * __reg[2]);
					var __y2 = __ty + (__ys * __reg[3]);
					
					if (__x1 > __x2) { var __tmp = __x1; __x1 = __x2; __x2 = __tmp; }
					if (__y1 > __y2) { var __tmp = __y1; __y1 = __y2; __y2 = __tmp; }
					
					__tiles_in_layer[__t_idx++] = [__x1, __y1, __x2, __y2, __el];
				}
			}
			
			if (__t_idx > 0) {
				if (ds_map_exists(global.__tile_depth_map, __d)) {
					var __existing = global.__tile_depth_map[? __d];
					for (var __m = 0; __m < __t_idx; __m++) {
						array_push(__existing, __tiles_in_layer[__m]);
					}
				} else {
					global.__tile_depth_map[? __d] = __tiles_in_layer;
				}
			}
		}
	}

	// Consulta instantánea sobre el mapa pre-calculado
	if (!ds_map_exists(global.__tile_depth_map, __depth)) {
		return -1;
	}

	var __tiles = global.__tile_depth_map[? __depth];
	var __count = array_length(__tiles);
	
	for (var __k = 0; __k < __count; __k++) {
		var __t = __tiles[__k];
		if (__x >= __t[0] && __x < __t[2] && __y >= __t[1] && __y < __t[3]) {
			return __t[4];
		}
	}

	return -1;

}
