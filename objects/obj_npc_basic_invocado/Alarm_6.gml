/// @description  Control posición

var i = 1;

tile1 = tile_layer_find(TILE_LAYER_GRASS, x, y);
tile2 = tile_layer_find(TILE_LAYER_COAST, x, y);
tile3 = tile_layer_find(TILE_LAYER_FLOORS, x, y);

while (place_meeting(x, y, obj_pj) || place_meeting(x, y, obj_bloque_basic) || place_meeting(x, y, obj_bloqueo_agua) || place_meeting(x, y, obj_npc_basic) || place_meeting(x, y, obj_oro) || place_meeting(x, y, obj_item) || (tile1 == -1 && tile2 == -1 && tile3 == -1)) {

    var banderaBreak = false;
    
    ////////////////////////////////////////////////////////////////////////////////
    // Si hay lugar arriba a la izquierda...
    
    tile1 = tile_layer_find(TILE_LAYER_GRASS, x - TILE_SIZE * i, y - TILE_SIZE * i); // Pasto
    tile2 = tile_layer_find(TILE_LAYER_COAST, x - TILE_SIZE * i, y - TILE_SIZE * i); // Costa
    tile3 = tile_layer_find(TILE_LAYER_FLOORS, x - TILE_SIZE * i, y - TILE_SIZE * i); // Pisos y puentes
    
    if (
    !place_meeting(x - TILE_SIZE * i, y - TILE_SIZE * i, obj_pj) && 
    !place_meeting(x - TILE_SIZE * i, y - TILE_SIZE * i, obj_bloque_basic) && 
    !place_meeting(x - TILE_SIZE * i, y - TILE_SIZE * i, obj_bloqueo_agua) && 
    !place_meeting(x - TILE_SIZE * i, y - TILE_SIZE * i, obj_npc_basic) &&
    !place_meeting(x - TILE_SIZE * i, y - TILE_SIZE * i, obj_oro) &&
    !place_meeting(x - TILE_SIZE * i, y - TILE_SIZE * i, obj_item) &&
    (tile1 != -1 || tile2 != -1 || tile3 != -1) // Si hay algún tipo de suelo...
    ) {
        
        x -= TILE_SIZE * i;
        y -= TILE_SIZE * i;
        break;
        
    }
    
    if (i > 1) {
    
        for (var iAux = i; iAux >= i - 1; iAux--) {
        
            tile1 = tile_layer_find(TILE_LAYER_GRASS, (x - TILE_SIZE * iAux) + TILE_SIZE, y - TILE_SIZE * i);
            tile2 = tile_layer_find(TILE_LAYER_COAST, (x - TILE_SIZE * iAux) + TILE_SIZE, y - TILE_SIZE * i);
            tile3 = tile_layer_find(TILE_LAYER_FLOORS, (x - TILE_SIZE * iAux) + TILE_SIZE, y - TILE_SIZE * i);
        
            if (
            !place_meeting((x - TILE_SIZE * iAux) + TILE_SIZE, y - TILE_SIZE * i, obj_pj) && 
            !place_meeting((x - TILE_SIZE * iAux) + TILE_SIZE, y - TILE_SIZE * i, obj_bloque_basic) && 
            !place_meeting((x - TILE_SIZE * iAux) + TILE_SIZE, y - TILE_SIZE * i, obj_bloqueo_agua) && 
            !place_meeting((x - TILE_SIZE * iAux) + TILE_SIZE, y - TILE_SIZE * i, obj_npc_basic) &&
            !place_meeting((x - TILE_SIZE * iAux) + TILE_SIZE, y - TILE_SIZE * i, obj_oro) &&
            !place_meeting((x - TILE_SIZE * iAux) + TILE_SIZE, y - TILE_SIZE * i, obj_item) &&
            (tile1 != -1 || tile2 != -1 || tile3 != -1) // Si hay algún tipo de suelo...
            ) {
                
                x = (x - TILE_SIZE * iAux) + TILE_SIZE;
                y -= TILE_SIZE * i;
                banderaBreak = true;
                break;
                
            }
            
        }
        
        if (banderaBreak) {
            break;
        }
        
        for (var iAux = i; iAux >= i - 1; iAux--) {
        
            tile1 = tile_layer_find(TILE_LAYER_GRASS, x - TILE_SIZE * i, (y - TILE_SIZE * iAux) + TILE_SIZE);
            tile2 = tile_layer_find(TILE_LAYER_COAST, x - TILE_SIZE * i, (y - TILE_SIZE * iAux) + TILE_SIZE);
            tile3 = tile_layer_find(TILE_LAYER_FLOORS, x - TILE_SIZE * i, (y - TILE_SIZE * iAux) + TILE_SIZE);
        
            if (
            !place_meeting(x - TILE_SIZE * i, (y - TILE_SIZE * iAux) + TILE_SIZE, obj_pj) && 
            !place_meeting(x - TILE_SIZE * i, (y - TILE_SIZE * iAux) + TILE_SIZE, obj_bloque_basic) && 
            !place_meeting(x - TILE_SIZE * i, (y - TILE_SIZE * iAux) + TILE_SIZE, obj_bloqueo_agua) && 
            !place_meeting(x - TILE_SIZE * i, (y - TILE_SIZE * iAux) + TILE_SIZE, obj_npc_basic) && 
            !place_meeting(x - TILE_SIZE * i, (y - TILE_SIZE * iAux) + TILE_SIZE, obj_oro) &&
            !place_meeting(x - TILE_SIZE * i, (y - TILE_SIZE * iAux) + TILE_SIZE, obj_item) &&
            (tile1 != -1 || tile2 != -1 || tile3 != -1) // Si hay algún tipo de suelo...
            ) {
                
                x -= TILE_SIZE * i;
                y = (y - TILE_SIZE * iAux) + TILE_SIZE;
                banderaBreak = true;
                break;
                
            }
            
        }
        
        if (banderaBreak) {
            break;
        }
        
    }
    
    ////////////////////////////////////////////////////////////////////////////////
    
    ////////////////////////////////////////////////////////////////////////////////
    // Si hay lugar arriba...
    
    tile1 = tile_layer_find(TILE_LAYER_GRASS, x, y - TILE_SIZE * i);
    tile2 = tile_layer_find(TILE_LAYER_COAST, x, y - TILE_SIZE * i);
    tile3 = tile_layer_find(TILE_LAYER_FLOORS, x, y - TILE_SIZE * i);
    
    if (
    !place_meeting(x, y - TILE_SIZE * i, obj_pj) && 
    !place_meeting(x, y - TILE_SIZE * i, obj_bloque_basic) && 
    !place_meeting(x, y - TILE_SIZE * i, obj_bloqueo_agua) && 
    !place_meeting(x, y - TILE_SIZE * i, obj_npc_basic) &&
    !place_meeting(x, y - TILE_SIZE * i, obj_oro) &&
    !place_meeting(x, y - TILE_SIZE * i, obj_item) &&
    (tile1 != -1 || tile2 != -1 || tile3 != -1) // Si hay algún tipo de suelo...
    ) {
        
        y -= TILE_SIZE * i;
        break;
        
    }
    
    ////////////////////////////////////////////////////////////////////////////////
    
    ////////////////////////////////////////////////////////////////////////////////
    // Si hay lugar arriba a la derecha...
        
    if (i > 1) {
    
        for (var iAux = 1; iAux <= i; iAux++) {
        
            tile1 = tile_layer_find(TILE_LAYER_GRASS, (x + TILE_SIZE * iAux) + TILE_SIZE, y - TILE_SIZE * i);
            tile2 = tile_layer_find(TILE_LAYER_COAST, (x + TILE_SIZE * iAux) + TILE_SIZE, y - TILE_SIZE * i);
            tile3 = tile_layer_find(TILE_LAYER_FLOORS, (x + TILE_SIZE * iAux) + TILE_SIZE, y - TILE_SIZE * i);
        
            if (
            !place_meeting((x + TILE_SIZE * iAux) - TILE_SIZE, y - TILE_SIZE * i, obj_pj) && 
            !place_meeting((x + TILE_SIZE * iAux) - TILE_SIZE, y - TILE_SIZE * i, obj_bloque_basic) && 
            !place_meeting((x + TILE_SIZE * iAux) - TILE_SIZE, y - TILE_SIZE * i, obj_bloqueo_agua) && 
            !place_meeting((x + TILE_SIZE * iAux) - TILE_SIZE, y - TILE_SIZE * i, obj_npc_basic) &&
            !place_meeting((x + TILE_SIZE * iAux) - TILE_SIZE, y - TILE_SIZE * i, obj_oro) &&
            !place_meeting((x + TILE_SIZE * iAux) - TILE_SIZE, y - TILE_SIZE * i, obj_item) &&
            (tile1 != -1 || tile2 != -1 || tile3 != -1) // Si hay algún tipo de suelo...
            ) {
                
                x = (x + TILE_SIZE * iAux) - TILE_SIZE;
                y -= TILE_SIZE * i;
                banderaBreak = true;
                break;
                
            }
            
        }
        
        if (banderaBreak) {
            break;
        }
        
    }
    
    tile1 = tile_layer_find(TILE_LAYER_GRASS, x + TILE_SIZE * i, y - TILE_SIZE * i);
    tile2 = tile_layer_find(TILE_LAYER_COAST, x + TILE_SIZE * i, y - TILE_SIZE * i);
    tile3 = tile_layer_find(TILE_LAYER_FLOORS, x + TILE_SIZE * i, y - TILE_SIZE * i);
    
    if (
    !place_meeting(x + TILE_SIZE * i, y - TILE_SIZE * i, obj_pj) && 
    !place_meeting(x + TILE_SIZE * i, y - TILE_SIZE * i, obj_bloque_basic) && 
    !place_meeting(x + TILE_SIZE * i, y - TILE_SIZE * i, obj_bloqueo_agua) && 
    !place_meeting(x + TILE_SIZE * i, y - TILE_SIZE * i, obj_npc_basic) &&
    !place_meeting(x + TILE_SIZE * i, y - TILE_SIZE * i, obj_oro) &&
    !place_meeting(x + TILE_SIZE * i, y - TILE_SIZE * i, obj_item) &&
    (tile1 != -1 || tile2 != -1 || tile3 != -1) // Si hay algún tipo de suelo...
    ) {
        
        x += TILE_SIZE * i;
        y -= TILE_SIZE * i;
        break;
        
    }
    
    if (i > 1) {
        
        for (var iAux = i; iAux >= i - 1; iAux--) {
        
            tile1 = tile_layer_find(TILE_LAYER_GRASS, x + TILE_SIZE * i, (y - TILE_SIZE * iAux) + TILE_SIZE);
            tile2 = tile_layer_find(TILE_LAYER_COAST, x + TILE_SIZE * i, (y - TILE_SIZE * iAux) + TILE_SIZE);
            tile3 = tile_layer_find(TILE_LAYER_FLOORS, x + TILE_SIZE * i, (y - TILE_SIZE * iAux) + TILE_SIZE);
        
            if (
            !place_meeting(x + TILE_SIZE * i, (y - TILE_SIZE * iAux) + TILE_SIZE, obj_pj) && 
            !place_meeting(x + TILE_SIZE * i, (y - TILE_SIZE * iAux) + TILE_SIZE, obj_bloque_basic) && 
            !place_meeting(x + TILE_SIZE * i, (y - TILE_SIZE * iAux) + TILE_SIZE, obj_bloqueo_agua) && 
            !place_meeting(x + TILE_SIZE * i, (y - TILE_SIZE * iAux) + TILE_SIZE, obj_npc_basic) && 
            !place_meeting(x + TILE_SIZE * i, (y - TILE_SIZE * iAux) + TILE_SIZE, obj_oro) &&
            !place_meeting(x + TILE_SIZE * i, (y - TILE_SIZE * iAux) + TILE_SIZE, obj_item) &&
            (tile1 != -1 || tile2 != -1 || tile3 != -1) // Si hay algún tipo de suelo...
            ) {
                
                x += TILE_SIZE * i;
                y = (y - TILE_SIZE * iAux) + TILE_SIZE;
                banderaBreak = true;
                break;
                
            }
            
        }
        
        if (banderaBreak) {
            break;
        }
        
    }
    
    ////////////////////////////////////////////////////////////////////////////////
    
    ////////////////////////////////////////////////////////////////////////////////
    // Si hay lugar a la derecha...
    
    tile1 = tile_layer_find(TILE_LAYER_GRASS, x + TILE_SIZE * i, y);
    tile2 = tile_layer_find(TILE_LAYER_COAST, x + TILE_SIZE * i, y);
    tile3 = tile_layer_find(TILE_LAYER_FLOORS, x + TILE_SIZE * i, y);
    
    if (
    !place_meeting(x + TILE_SIZE * i, y, obj_pj) && 
    !place_meeting(x + TILE_SIZE * i, y, obj_bloque_basic) && 
    !place_meeting(x + TILE_SIZE * i, y, obj_bloqueo_agua) && 
    !place_meeting(x + TILE_SIZE * i, y, obj_npc_basic) &&
    !place_meeting(x + TILE_SIZE * i, y, obj_oro) &&
    !place_meeting(x + TILE_SIZE * i, y, obj_item) &&
    (tile1 != -1 || tile2 != -1 || tile3 != -1) // Si hay algún tipo de suelo...
    ) {
        
        x += TILE_SIZE * i;
        break;
        
    }
    
    ////////////////////////////////////////////////////////////////////////////////
    
    ////////////////////////////////////////////////////////////////////////////////
    // Si hay lugar abajo a la derecha...
    
    if (i > 1) {
        
        for (var iAux = 1; iAux <= i; iAux++) {
        
            tile1 = tile_layer_find(TILE_LAYER_GRASS, x + TILE_SIZE * i, (y + TILE_SIZE * iAux) + TILE_SIZE);
            tile2 = tile_layer_find(TILE_LAYER_COAST, x + TILE_SIZE * i, (y + TILE_SIZE * iAux) + TILE_SIZE);
            tile3 = tile_layer_find(TILE_LAYER_FLOORS, x + TILE_SIZE * i, (y + TILE_SIZE * iAux) + TILE_SIZE);
        
            if (
            !place_meeting(x + TILE_SIZE * i, (y + TILE_SIZE * iAux) - TILE_SIZE, obj_pj) && 
            !place_meeting(x + TILE_SIZE * i, (y + TILE_SIZE * iAux) - TILE_SIZE, obj_bloque_basic) && 
            !place_meeting(x + TILE_SIZE * i, (y + TILE_SIZE * iAux) - TILE_SIZE, obj_bloqueo_agua) && 
            !place_meeting(x + TILE_SIZE * i, (y + TILE_SIZE * iAux) - TILE_SIZE, obj_npc_basic) && 
            !place_meeting(x + TILE_SIZE * i, (y + TILE_SIZE * iAux) - TILE_SIZE, obj_oro) &&
            !place_meeting(x + TILE_SIZE * i, (y + TILE_SIZE * iAux) - TILE_SIZE, obj_item) &&
            (tile1 != -1 || tile2 != -1 || tile3 != -1) // Si hay algún tipo de suelo...
            ) {
                
                x += TILE_SIZE * i;
                y = (y + TILE_SIZE * iAux) - TILE_SIZE;
                banderaBreak = true;
                break;
                
            }
            
        }
        
        if (banderaBreak) {
            break;
        }
    
    }
    
    tile1 = tile_layer_find(TILE_LAYER_GRASS, x + TILE_SIZE * i, y + TILE_SIZE * i);
    tile2 = tile_layer_find(TILE_LAYER_COAST, x + TILE_SIZE * i, y + TILE_SIZE * i);
    tile3 = tile_layer_find(TILE_LAYER_FLOORS, x + TILE_SIZE * i, y + TILE_SIZE * i);
    
    if (
    !place_meeting(x + TILE_SIZE * i, y + TILE_SIZE * i, obj_pj) && 
    !place_meeting(x + TILE_SIZE * i, y + TILE_SIZE * i, obj_bloque_basic) && 
    !place_meeting(x + TILE_SIZE * i, y + TILE_SIZE * i, obj_bloqueo_agua) && 
    !place_meeting(x + TILE_SIZE * i, y + TILE_SIZE * i, obj_npc_basic) &&
    !place_meeting(x + TILE_SIZE * i, y + TILE_SIZE * i, obj_oro) &&
    !place_meeting(x + TILE_SIZE * i, y + TILE_SIZE * i, obj_item) &&
    (tile1 != -1 || tile2 != -1 || tile3 != -1) // Si hay algún tipo de suelo...
    ) {
        
        x += TILE_SIZE * i;
        y += TILE_SIZE * i;
        break;
        
    }
    
    if (i > 1) {
    
        for (var iAux = i; iAux >= i - 1; iAux--) {
        
            tile1 = tile_layer_find(TILE_LAYER_GRASS, (x + TILE_SIZE * iAux) + TILE_SIZE, y + TILE_SIZE * i);
            tile2 = tile_layer_find(TILE_LAYER_COAST, (x + TILE_SIZE * iAux) + TILE_SIZE, y + TILE_SIZE * i);
            tile3 = tile_layer_find(TILE_LAYER_FLOORS, (x + TILE_SIZE * iAux) + TILE_SIZE, y + TILE_SIZE * i);
        
            if (
            !place_meeting((x + TILE_SIZE * iAux) - TILE_SIZE, y + TILE_SIZE * i, obj_pj) && 
            !place_meeting((x + TILE_SIZE * iAux) - TILE_SIZE, y + TILE_SIZE * i, obj_bloque_basic) && 
            !place_meeting((x + TILE_SIZE * iAux) - TILE_SIZE, y + TILE_SIZE * i, obj_bloqueo_agua) && 
            !place_meeting((x + TILE_SIZE * iAux) - TILE_SIZE, y + TILE_SIZE * i, obj_npc_basic) &&
            !place_meeting((x + TILE_SIZE * iAux) - TILE_SIZE, y + TILE_SIZE * i, obj_oro) &&
            !place_meeting((x + TILE_SIZE * iAux) - TILE_SIZE, y + TILE_SIZE * i, obj_item) &&
            (tile1 != -1 || tile2 != -1 || tile3 != -1) // Si hay algún tipo de suelo...
            ) {
                
                x = (x + TILE_SIZE * iAux) - TILE_SIZE;
                y += TILE_SIZE * i;
                banderaBreak = true;
                break;
                
            }
            
        }
        
        if (banderaBreak) {
            break;
        }
        
    }
    
    ////////////////////////////////////////////////////////////////////////////////
    
    ////////////////////////////////////////////////////////////////////////////////
    // Si hay lugar abajo...
    
    tile1 = tile_layer_find(TILE_LAYER_GRASS, x, y + TILE_SIZE * i);
    tile2 = tile_layer_find(TILE_LAYER_COAST, x, y + TILE_SIZE * i);
    tile3 = tile_layer_find(TILE_LAYER_FLOORS, x, y + TILE_SIZE * i);
    
    if (
    !place_meeting(x, y + TILE_SIZE * i, obj_pj) && 
    !place_meeting(x, y + TILE_SIZE * i, obj_bloque_basic) && 
    !place_meeting(x, y + TILE_SIZE * i, obj_bloqueo_agua) && 
    !place_meeting(x, y + TILE_SIZE * i, obj_npc_basic) &&
    !place_meeting(x, y + TILE_SIZE * i, obj_oro) &&
    !place_meeting(x, y + TILE_SIZE * i, obj_item) &&
    (tile1 != -1 || tile2 != -1 || tile3 != -1) // Si hay algún tipo de suelo...
    ) {
        
        y += TILE_SIZE * i;
        break;
        
    }
    
    ////////////////////////////////////////////////////////////////////////////////
    
    ////////////////////////////////////////////////////////////////////////////////
    // Si hay lugar abajo a la izquierda...
    
    if (i > 1) {
    
        for (var iAux = 1; iAux <= i; iAux++) {
        
            tile1 = tile_layer_find(TILE_LAYER_GRASS, (x - TILE_SIZE * iAux) + TILE_SIZE, y + TILE_SIZE * i);
            tile2 = tile_layer_find(TILE_LAYER_COAST, (x - TILE_SIZE * iAux) + TILE_SIZE, y + TILE_SIZE * i);
            tile3 = tile_layer_find(TILE_LAYER_FLOORS, (x - TILE_SIZE * iAux) + TILE_SIZE, y + TILE_SIZE * i);
        
            if (
            !place_meeting((x - TILE_SIZE * iAux) + TILE_SIZE, y + TILE_SIZE * i, obj_pj) && 
            !place_meeting((x - TILE_SIZE * iAux) + TILE_SIZE, y + TILE_SIZE * i, obj_bloque_basic) && 
            !place_meeting((x - TILE_SIZE * iAux) + TILE_SIZE, y + TILE_SIZE * i, obj_bloqueo_agua) && 
            !place_meeting((x - TILE_SIZE * iAux) + TILE_SIZE, y + TILE_SIZE * i, obj_npc_basic) &&
            !place_meeting((x - TILE_SIZE * iAux) + TILE_SIZE, y + TILE_SIZE * i, obj_oro) &&
            !place_meeting((x - TILE_SIZE * iAux) + TILE_SIZE, y + TILE_SIZE * i, obj_item) &&
            (tile1 != -1 || tile2 != -1 || tile3 != -1) // Si hay algún tipo de suelo...
            ) {
                
                x = (x - TILE_SIZE * iAux) + TILE_SIZE;
                y += TILE_SIZE * i;
                banderaBreak = true;
                break;
                
            }
            
        }
        
        if (banderaBreak) {
            break;
        }
        
    }
    
    tile1 = tile_layer_find(TILE_LAYER_GRASS, x - TILE_SIZE * i, y + TILE_SIZE * i);
    tile2 = tile_layer_find(TILE_LAYER_COAST, x - TILE_SIZE * i, y + TILE_SIZE * i);
    tile3 = tile_layer_find(TILE_LAYER_FLOORS, x - TILE_SIZE * i, y + TILE_SIZE * i);
    
    if (
    !place_meeting(x - TILE_SIZE * i, y + TILE_SIZE * i, obj_pj) && 
    !place_meeting(x - TILE_SIZE * i, y + TILE_SIZE * i, obj_bloque_basic) && 
    !place_meeting(x - TILE_SIZE * i, y + TILE_SIZE * i, obj_bloqueo_agua) && 
    !place_meeting(x - TILE_SIZE * i, y + TILE_SIZE * i, obj_npc_basic) &&
    !place_meeting(x - TILE_SIZE * i, y + TILE_SIZE * i, obj_oro) &&
    !place_meeting(x - TILE_SIZE * i, y + TILE_SIZE * i, obj_item) &&
    (tile1 != -1 || tile2 != -1 || tile3 != -1) // Si hay algún tipo de suelo...
    ) {
        
        x -= TILE_SIZE * i;
        y += TILE_SIZE * i;
        break;
        
    }
    
    if (i > 1) {
        
        for (var iAux = i; iAux >= i - 1; iAux--) {
        
            tile1 = tile_layer_find(TILE_LAYER_GRASS, x - TILE_SIZE * i, (y + TILE_SIZE * iAux) - TILE_SIZE);
            tile2 = tile_layer_find(TILE_LAYER_COAST, x - TILE_SIZE * i, (y + TILE_SIZE * iAux) - TILE_SIZE);
            tile3 = tile_layer_find(TILE_LAYER_FLOORS, x - TILE_SIZE * i, (y + TILE_SIZE * iAux) - TILE_SIZE);
        
            if (
            !place_meeting(x - TILE_SIZE * i, (y + TILE_SIZE * iAux) - TILE_SIZE, obj_pj) && 
            !place_meeting(x - TILE_SIZE * i, (y + TILE_SIZE * iAux) - TILE_SIZE, obj_bloque_basic) && 
            !place_meeting(x - TILE_SIZE * i, (y + TILE_SIZE * iAux) - TILE_SIZE, obj_bloqueo_agua) && 
            !place_meeting(x - TILE_SIZE * i, (y + TILE_SIZE * iAux) - TILE_SIZE, obj_npc_basic) && 
            !place_meeting(x - TILE_SIZE * i, (y + TILE_SIZE * iAux) - TILE_SIZE, obj_oro) &&
            !place_meeting(x - TILE_SIZE * i, (y + TILE_SIZE * iAux) - TILE_SIZE, obj_item) &&
            (tile1 != -1 || tile2 != -1 || tile3 != -1) // Si hay algún tipo de suelo...
            ) {
                
                x -= TILE_SIZE * i;
                y = (y + TILE_SIZE * iAux) - TILE_SIZE;
                banderaBreak = true;
                break;
                
            }
            
        }
        
        if (banderaBreak) {
            break;
        }
    
    }
    
    ////////////////////////////////////////////////////////////////////////////////
    
    ////////////////////////////////////////////////////////////////////////////////
    // Si hay lugar a la izquierda...
    
    tile1 = tile_layer_find(TILE_LAYER_GRASS, x - TILE_SIZE * i, y);
    tile2 = tile_layer_find(TILE_LAYER_COAST, x - TILE_SIZE * i, y);
    tile3 = tile_layer_find(TILE_LAYER_FLOORS, x - TILE_SIZE * i, y);
    
    if (
    !place_meeting(x - TILE_SIZE * i, y, obj_pj) && 
    !place_meeting(x - TILE_SIZE * i, y, obj_bloque_basic) && 
    !place_meeting(x - TILE_SIZE * i, y, obj_bloqueo_agua) && 
    !place_meeting(x - TILE_SIZE * i, y, obj_npc_basic) &&
    !place_meeting(x - TILE_SIZE * i, y, obj_oro) &&
    !place_meeting(x - TILE_SIZE * i, y, obj_item) &&
    (tile1 != -1 || tile2 != -1 || tile3 != -1) // Si hay algún tipo de suelo...
    ) {
        
        x -= TILE_SIZE * i;
        break;
        
    }
    
    ////////////////////////////////////////////////////////////////////////////////
    
    // Reinicio variables
    
    tile1 = tile_layer_find(TILE_LAYER_GRASS, x, y);
    tile2 = tile_layer_find(TILE_LAYER_COAST, x, y);
    tile3 = tile_layer_find(TILE_LAYER_FLOORS, x, y);
                
    // Si cierra el ciclo...
    
    i++;
    
    if (i * TILE_SIZE > get_render_width() * 0.75) {
        domado = true;
        instance_destroy();
    }

}

visible = true;
var idEfecto = instance_create_depth(x, y, 0, obj_efecto_login);
idEfecto.padre = id;

