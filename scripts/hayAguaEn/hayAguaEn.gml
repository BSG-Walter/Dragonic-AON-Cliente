/// @description  hayAguaEn(x, y)
/// @param x
/// @param y
function hayAguaEn(argument0, argument1) {

	var xPos = argument0;
	var yPos = argument1;
	
	// Inicializar la cuadrícula espacial de agua si cambió de sala
	if (!variable_global_exists("__agua_cached_room") || global.__agua_cached_room != room) {
		global.__agua_cached_room = room;
		
		var layAgua = layer_get_id("Background_Agua");
		var tieneAgua = (layAgua != -1 && layer_get_visible(layAgua));
		
		// Salas especiales o subterráneas sin agua
		if (room == rm_83 || room == rm_84 || room == rm_85 || room == rm_86 || room == rm_87 || room == rm_88 || room == rm_89 || room == rm_90 || room == rm_91 || room == rm_92 || room == rm_93 || room == rm_158 || room == rm_159 || room == rm_arena) {
			tieneAgua = false;
		}
		
		global.__agua_tiene_agua = tieneAgua;
		
		if (variable_global_exists("__agua_grid") && ds_exists(global.__agua_grid, ds_type_grid)) {
			ds_grid_destroy(global.__agua_grid);
		}
		
		var gw = max(1, room_width div TILE_SIZE);
		var gh = max(1, room_height div TILE_SIZE);
		global.__agua_gw = gw;
		global.__agua_gh = gh;
		global.__agua_grid = ds_grid_create(gw, gh);
		
		if (!tieneAgua) {
			ds_grid_set_region(global.__agua_grid, 0, 0, gw - 1, gh - 1, 0);
		} else {
			// Iniciar todo como agua (1)
			ds_grid_set_region(global.__agua_grid, 0, 0, gw - 1, gh - 1, 1);
			
			// Estampar como tierra (0) todas las áreas cubiertas por tiles de pasto, costas, pisos, paredes o techos
			var all_layers = layer_get_all();
			var num_layers = array_length(all_layers);
			
			for (var i = 0; i < num_layers; i++) {
				var lay = all_layers[i];
				var d = layer_get_depth(lay);
				
				// Solo procesar capas de tierra/construcción
				if (d == 10000000 || d == 1000000 || d == 100000 || d == 10000 || d == 1000) {
					var elements = layer_get_all_elements(lay);
					var num_elements = array_length(elements);
					
					for (var j = 0; j < num_elements; j++) {
						var el = elements[j];
						var el_type = layer_get_element_type(el);
						
						if (el_type == layerelementtype_tile) {
							var tx = layer_tile_get_x(el);
							var ty = layer_tile_get_y(el);
							var xs = layer_tile_get_xscale(el);
							var ys = layer_tile_get_yscale(el);
							var reg = layer_tile_get_region(el);
							
							var x1 = tx;
							var y1 = ty;
							var x2 = tx + (xs * reg[2]);
							var y2 = ty + (ys * reg[3]);
							
							if (x1 > x2) { var tmp = x1; x1 = x2; x2 = tmp; }
							if (y1 > y2) { var tmp = y1; y1 = y2; y2 = tmp; }
							
							var gx1 = clamp(x1 div TILE_SIZE, 0, gw - 1);
							var gy1 = clamp(y1 div TILE_SIZE, 0, gh - 1);
							var gx2 = clamp((x2 - 1) div TILE_SIZE, 0, gw - 1);
							var gy2 = clamp((y2 - 1) div TILE_SIZE, 0, gh - 1);
							
							ds_grid_set_region(global.__agua_grid, gx1, gy1, gx2, gy2, 0);
						} else if (el_type == layerelementtype_sprite) {
							var sx = layer_sprite_get_x(el);
							var sy = layer_sprite_get_y(el);
							var spr = layer_sprite_get_sprite(el);
							var sw = (spr != -1) ? sprite_get_width(spr) * layer_sprite_get_xscale(el) : TILE_SIZE;
							var sh = (spr != -1) ? sprite_get_height(spr) * layer_sprite_get_yscale(el) : TILE_SIZE;
							
							var gx1 = clamp(sx div TILE_SIZE, 0, gw - 1);
							var gy1 = clamp(sy div TILE_SIZE, 0, gh - 1);
							var gx2 = clamp((sx + sw - 1) div TILE_SIZE, 0, gw - 1);
							var gy2 = clamp((sy + sh - 1) div TILE_SIZE, 0, gh - 1);
							
							ds_grid_set_region(global.__agua_grid, gx1, gy1, gx2, gy2, 0);
						}
					}
				}
			}
		}
	}
	
	if (!global.__agua_tiene_agua) {
		return false;
	}
	
	var gx = xPos div TILE_SIZE;
	var gy = yPos div TILE_SIZE;
	
	if (gx < 0 || gx >= global.__agua_gw || gy < 0 || gy >= global.__agua_gh) {
		return false;
	}
	
	return (global.__agua_grid[# gx, gy] == 1);

}
