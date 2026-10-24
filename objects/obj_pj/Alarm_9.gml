if (online_activo()) exit;
if (global.online_exportando) exit;
/// @description  Control de posición de teletransporte / logueo / encierro

var i = 1;

var idBloqueo = instance_create_depth(x - 16, y, 0, obj_bloqueo);

tile = tile_layer_find(TILE_LAYER_COAST, x, y);

while (place_meeting(x, y, obj_bloque_basic) || place_meeting(x, y, obj_npc_basic) || place_meeting(x, y, obj_telep) || tile != -1 || encerrado) {

    encerrado = false;
    var banderaBreak = false;
    
    ////////////////////////////////////////////////////////////////////////////////
    // Si hay lugar arriba a la izquierda...
    
    tile = tile_layer_find(TILE_LAYER_COAST, x - TILE_SIZE * i, y - TILE_SIZE * i);
    
    if (
    !place_meeting(x - TILE_SIZE * i, y - TILE_SIZE * i, obj_bloque_basic) && 
    !place_meeting(x - TILE_SIZE * i, y - TILE_SIZE * i, obj_npc_basic) &&
    !place_meeting(x - TILE_SIZE * i, y - TILE_SIZE * i, obj_telep) &&
    tile == -1
    ) {
        
        x -= TILE_SIZE * i;
        y -= TILE_SIZE * i;
        break;
        
    }
    
    if (i > 1) {
    
        for (var iAux = i; iAux >= i - 1; iAux--) {
        
            tile = tile_layer_find(TILE_LAYER_COAST, (x - TILE_SIZE * iAux) + TILE_SIZE, y - TILE_SIZE * i);
        
            if (
            !place_meeting((x - TILE_SIZE * iAux) + TILE_SIZE, y - TILE_SIZE * i, obj_bloque_basic) && 
            !place_meeting((x - TILE_SIZE * iAux) + TILE_SIZE, y - TILE_SIZE * i, obj_npc_basic) &&
            !place_meeting((x - TILE_SIZE * iAux) + TILE_SIZE, y - TILE_SIZE * i, obj_telep) &&
            tile == -1
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
        
            tile = tile_layer_find(TILE_LAYER_COAST, x - TILE_SIZE * i, (y - TILE_SIZE * iAux) + TILE_SIZE);
        
            if (
            !place_meeting(x - TILE_SIZE * i, (y - TILE_SIZE * iAux) + TILE_SIZE, obj_bloque_basic) && 
            !place_meeting(x - TILE_SIZE * i, (y - TILE_SIZE * iAux) + TILE_SIZE, obj_npc_basic) && 
            !place_meeting(x - TILE_SIZE * i, (y - TILE_SIZE * iAux) + TILE_SIZE, obj_telep) && 
            tile == -1
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
    
    tile = tile_layer_find(TILE_LAYER_COAST, x, y - TILE_SIZE * i);
    
    if (
    !place_meeting(x, y - TILE_SIZE * i, obj_bloque_basic) && 
    !place_meeting(x, y - TILE_SIZE * i, obj_npc_basic) &&
    !place_meeting(x, y - TILE_SIZE * i, obj_telep) &&
    tile == -1
    ) {
        
        y -= TILE_SIZE * i;
        break;
        
    }
    
    ////////////////////////////////////////////////////////////////////////////////
    
    ////////////////////////////////////////////////////////////////////////////////
    // Si hay lugar arriba a la derecha...
        
    if (i > 1) {
    
        for (var iAux = 1; iAux <= i; iAux++) {
        
            tile = tile_layer_find(TILE_LAYER_COAST, (x + TILE_SIZE * iAux) + TILE_SIZE, y - TILE_SIZE * i);
        
            if (
            !place_meeting((x + TILE_SIZE * iAux) - TILE_SIZE, y - TILE_SIZE * i, obj_bloque_basic) && 
            !place_meeting((x + TILE_SIZE * iAux) - TILE_SIZE, y - TILE_SIZE * i, obj_npc_basic) &&
            !place_meeting((x + TILE_SIZE * iAux) - TILE_SIZE, y - TILE_SIZE * i, obj_telep) &&
            tile == -1
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
    
    tile = tile_layer_find(TILE_LAYER_COAST, x + TILE_SIZE * i, y - TILE_SIZE * i);
    
    if (
    !place_meeting(x + TILE_SIZE * i, y - TILE_SIZE * i, obj_bloque_basic) && 
    !place_meeting(x + TILE_SIZE * i, y - TILE_SIZE * i, obj_npc_basic) &&
    !place_meeting(x + TILE_SIZE * i, y - TILE_SIZE * i, obj_telep) &&
            tile == -1
    ) {
        
        x += TILE_SIZE * i;
        y -= TILE_SIZE * i;
        break;
        
    }
    
    if (i > 1) {
        
        for (var iAux = i; iAux >= i - 1; iAux--) {
        
            tile = tile_layer_find(TILE_LAYER_COAST, x + TILE_SIZE * i, (y - TILE_SIZE * iAux) + TILE_SIZE);
        
            if (
            !place_meeting(x + TILE_SIZE * i, (y - TILE_SIZE * iAux) + TILE_SIZE, obj_bloque_basic) && 
            !place_meeting(x + TILE_SIZE * i, (y - TILE_SIZE * iAux) + TILE_SIZE, obj_npc_basic) && 
            !place_meeting(x + TILE_SIZE * i, (y - TILE_SIZE * iAux) + TILE_SIZE, obj_telep) && 
            tile == -1
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
    
    tile = tile_layer_find(TILE_LAYER_COAST, x + TILE_SIZE * i, y);
    
    if (
    !place_meeting(x + TILE_SIZE * i, y, obj_bloque_basic) && 
    !place_meeting(x + TILE_SIZE * i, y, obj_npc_basic) &&
    !place_meeting(x + TILE_SIZE * i, y, obj_telep) &&
    tile == -1
    ) {
        
        x += TILE_SIZE * i;
        break;
        
    }
    
    ////////////////////////////////////////////////////////////////////////////////
    
    ////////////////////////////////////////////////////////////////////////////////
    // Si hay lugar abajo a la derecha...
    
    if (i > 1) {
        
        for (var iAux = 1; iAux <= i; iAux++) {
        
            tile = tile_layer_find(TILE_LAYER_COAST, x + TILE_SIZE * i, (y + TILE_SIZE * iAux) + TILE_SIZE);
        
            if (
            !place_meeting(x + TILE_SIZE * i, (y + TILE_SIZE * iAux) - TILE_SIZE, obj_bloque_basic) && 
            !place_meeting(x + TILE_SIZE * i, (y + TILE_SIZE * iAux) - TILE_SIZE, obj_npc_basic) && 
            !place_meeting(x + TILE_SIZE * i, (y + TILE_SIZE * iAux) - TILE_SIZE, obj_telep) && 
            tile == -1
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
    
    tile = tile_layer_find(TILE_LAYER_COAST, x + TILE_SIZE * i, y + TILE_SIZE * i);
    
    if (
    !place_meeting(x + TILE_SIZE * i, y + TILE_SIZE * i, obj_bloque_basic) && 
    !place_meeting(x + TILE_SIZE * i, y + TILE_SIZE * i, obj_npc_basic) &&
    !place_meeting(x + TILE_SIZE * i, y + TILE_SIZE * i, obj_telep) &&
            tile == -1
    ) {
        
        x += TILE_SIZE * i;
        y += TILE_SIZE * i;
        break;
        
    }
    
    if (i > 1) {
    
        for (var iAux = i; iAux >= i - 1; iAux--) {
        
            tile = tile_layer_find(TILE_LAYER_COAST, (x + TILE_SIZE * iAux) + TILE_SIZE, y + TILE_SIZE * i);
        
            if (
            !place_meeting((x + TILE_SIZE * iAux) - TILE_SIZE, y + TILE_SIZE * i, obj_bloque_basic) && 
            !place_meeting((x + TILE_SIZE * iAux) - TILE_SIZE, y + TILE_SIZE * i, obj_npc_basic) &&
            !place_meeting((x + TILE_SIZE * iAux) - TILE_SIZE, y + TILE_SIZE * i, obj_telep) &&
            tile == -1
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
    
    tile = tile_layer_find(TILE_LAYER_COAST, x, y + TILE_SIZE * i);
    
    if (
    !place_meeting(x, y + TILE_SIZE * i, obj_bloque_basic) && 
    !place_meeting(x, y + TILE_SIZE * i, obj_npc_basic) &&
    !place_meeting(x, y + TILE_SIZE * i, obj_telep) &&
    tile == -1
    ) {
        
        y += TILE_SIZE * i;
        break;
        
    }
    
    ////////////////////////////////////////////////////////////////////////////////
    
    ////////////////////////////////////////////////////////////////////////////////
    // Si hay lugar abajo a la izquierda...
    
    if (i > 1) {
    
        for (var iAux = 1; iAux <= i; iAux++) {
        
            tile = tile_layer_find(TILE_LAYER_COAST, (x - TILE_SIZE * iAux) + TILE_SIZE, y + TILE_SIZE * i);
        
            if (
            !place_meeting((x - TILE_SIZE * iAux) + TILE_SIZE, y + TILE_SIZE * i, obj_bloque_basic) && 
            !place_meeting((x - TILE_SIZE * iAux) + TILE_SIZE, y + TILE_SIZE * i, obj_npc_basic) &&
            !place_meeting((x - TILE_SIZE * iAux) + TILE_SIZE, y + TILE_SIZE * i, obj_telep) &&
            tile == -1
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
    
    tile = tile_layer_find(TILE_LAYER_COAST, x - TILE_SIZE * i, y + TILE_SIZE * i);
    
    if (
    !place_meeting(x - TILE_SIZE * i, y + TILE_SIZE * i, obj_bloque_basic) && 
    !place_meeting(x - TILE_SIZE * i, y + TILE_SIZE * i, obj_npc_basic) &&
    !place_meeting(x - TILE_SIZE * i, y + TILE_SIZE * i, obj_telep) &&
            tile == -1
    ) {
        
        x -= TILE_SIZE * i;
        y += TILE_SIZE * i;
        break;
        
    }
    
    if (i > 1) {
        
        for (var iAux = i; iAux >= i - 1; iAux--) {
        
            tile = tile_layer_find(TILE_LAYER_COAST, x - TILE_SIZE * i, (y + TILE_SIZE * iAux) - TILE_SIZE);
        
            if (
            !place_meeting(x - TILE_SIZE * i, (y + TILE_SIZE * iAux) - TILE_SIZE, obj_bloque_basic) && 
            !place_meeting(x - TILE_SIZE * i, (y + TILE_SIZE * iAux) - TILE_SIZE, obj_npc_basic) && 
            !place_meeting(x - TILE_SIZE * i, (y + TILE_SIZE * iAux) - TILE_SIZE, obj_telep) && 
            tile == -1
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
    
    tile = tile_layer_find(TILE_LAYER_COAST, x - TILE_SIZE * i, y);
    
    if (
    !place_meeting(x - TILE_SIZE * i, y, obj_bloque_basic) && 
    !place_meeting(x - TILE_SIZE * i, y, obj_npc_basic) &&
    !place_meeting(x - TILE_SIZE * i, y, obj_telep) &&
    tile == -1
    ) {
        
        x -= TILE_SIZE * i;
        break;
        
    }
    
    ////////////////////////////////////////////////////////////////////////////////
                
    // Si cierra el ciclo...
    
    i++;
    
    if (i * TILE_SIZE > get_render_width() * 0.75) {
        instance_destroy();
    }

}

if (instance_exists(idBloqueo)) {
    with (idBloqueo) {
        instance_destroy();
    }
}

if (!teletransporta) {
    instance_create_depth(x, y, 0, obj_efecto_login);
    reproducirSonido(snd_logueo, false, false);
}

alinearPJ()

teletransporta = false;


