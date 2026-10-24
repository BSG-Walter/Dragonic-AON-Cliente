/// @description  Gráfico

image_index = indice; 

/// Control posición

if (!noSetearAlarm) {

    if (!superpone) {
    
        var tile1 = tile_layer_find(TILE_LAYER_GRASS, x, y);
        var tile2 = tile_layer_find(TILE_LAYER_COAST, x, y);
        var tile3 = tile_layer_find(TILE_LAYER_FLOORS, x, y);
        
        var ocupado = place_meeting(x, y, obj_pj) || place_meeting(x, y, obj_bloque_basic) || place_meeting(x, y, obj_bloqueo_agua) || place_meeting(x, y, obj_tile_invalido) || place_meeting(x, y, obj_telep) || place_meeting(x, y, obj_npc_basic) || place_meeting(x, y, obj_oro) || place_meeting(x, y, obj_item) || (tile1 == -1 && tile2 == -1 && tile3 == -1);
        
        if (ocupado) {
            var found = false;
            // 8 vecinos a 32px
            var dirs = [[0,-TILE_SIZE],[TILE_SIZE,0],[0,TILE_SIZE],[-TILE_SIZE,0],[TILE_SIZE,-TILE_SIZE],[TILE_SIZE,TILE_SIZE],[-TILE_SIZE,TILE_SIZE],[-TILE_SIZE,-TILE_SIZE]];
            for (var d = 0; d < 8; d++) {
                var nx = x + dirs[d][0];
                var ny = y + dirs[d][1];
                tile1 = tile_layer_find(TILE_LAYER_GRASS, nx, ny);
                tile2 = tile_layer_find(TILE_LAYER_COAST, nx, ny);
                tile3 = tile_layer_find(TILE_LAYER_FLOORS, nx, ny);
                if (!place_meeting(nx, ny, obj_pj) && !place_meeting(nx, ny, obj_bloque_basic) && !place_meeting(nx, ny, obj_bloqueo_agua) && !place_meeting(nx, ny, obj_tile_invalido) && !place_meeting(nx, ny, obj_telep) && !place_meeting(nx, ny, obj_npc_basic) && !place_meeting(nx, ny, obj_oro) && !place_meeting(nx, ny, obj_item) && (tile1 != -1 || tile2 != -1 || tile3 != -1)) {
                    x = nx; y = ny; found = true; break;
                }
            }
            // si no hay lugar a TILE_SIZE, probar a 64 (4 direcciones)
            if (!found) {
                var dirs64 = [[0,TILE_SIZE*-2],[TILE_SIZE*2,0],[0,TILE_SIZE*2],[TILE_SIZE*-2,0]];
                for (var d = 0; d < 4; d++) {
                    var nx = x + dirs64[d][0];
                    var ny = y + dirs64[d][1];
                    tile1 = tile_layer_find(TILE_LAYER_GRASS, nx, ny);
                    tile2 = tile_layer_find(TILE_LAYER_COAST, nx, ny);
                    tile3 = tile_layer_find(TILE_LAYER_FLOORS, nx, ny);
                    if (!place_meeting(nx, ny, obj_pj) && !place_meeting(nx, ny, obj_bloque_basic) && !place_meeting(nx, ny, obj_bloqueo_agua) && !place_meeting(nx, ny, obj_tile_invalido) && !place_meeting(nx, ny, obj_telep) && !place_meeting(nx, ny, obj_npc_basic) && !place_meeting(nx, ny, obj_oro) && !place_meeting(nx, ny, obj_item) && (tile1 != -1 || tile2 != -1 || tile3 != -1)) {
                        x = nx; y = ny; found = true; break;
                    }
                }
            }
            if (!found) instance_destroy();
        }
    
    }

}

visible = true;
