/// @description  Control posición

if (!noSetearAlarm) {

    var tile1 = tile_layer_find(TILE_LAYER_GRASS, x, y);
    var tile2 = tile_layer_find(TILE_LAYER_COAST, x, y);
    var tile3 = tile_layer_find(TILE_LAYER_FLOORS, x, y);
    
    var ocupado = place_meeting(x, y, obj_pj) || place_meeting(x, y, obj_bloque_basic) || place_meeting(x, y, obj_bloqueo_agua) || place_meeting(x, y, obj_tile_invalido) || place_meeting(x, y, obj_telep) || place_meeting(x, y, obj_npc_basic) || place_meeting(x, y, obj_oro) || place_meeting(x, y, obj_item) || (tile1 == -1 && tile2 == -1 && tile3 == -1);
    
    if (ocupado) {
        var found = false;
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
        if (!found) {
            var dirs64 = [[0,-64],[64,0],[0,64],[-64,0]];
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

visible = true;
