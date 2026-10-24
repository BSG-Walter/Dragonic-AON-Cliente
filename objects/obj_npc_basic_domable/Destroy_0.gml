/// @description  Creo el oro (O drop)
/// @param O drop

// Si no estaba domado dropea

if (!domado && salud <= 0) {

    xOro = xInicio;
    yOro = yInicio;
    
    if (moviendose) {
    
        switch (direccion) {
            case 0:
                yOro += TILE_SIZE;
                break;
            case 1:
                yOro -= TILE_SIZE;
                break;
            case 2:
                xOro -= TILE_SIZE;
                break;
            case 3:
                xOro += TILE_SIZE;
                break;
        }
        
    }
	
    if (oro > 0) {    
	    var idOro = instance_create_depth(xOro, yOro, 0, obj_oro);
	    idOro.valor = oro * obj_opciones.multiOro; 
	}
	
    if (dropeaItem) {
	    var idItem = instance_create_depth(xOro, yOro, 0, obj_item);
	    idItem.indice = indItem;
	    idItem.cantidad = cantItem;
	}
    
}

// Si estaba domada desaparece

if (domado) {

    for (var i = 0; i < 3; i++) {
        if (obj_pj.criaturasHijas[i, 0] == id) {
            break;
        }
    }

    obj_pj.criaturasHijas[i, 0] = -1;
    
    if (salud <= 0) {
    
        obj_pj.criaturasHijas[i, 1] = -1;
    
        var idINFO = instance_create_depth(obj_pj.x, obj_pj.y, 0, obj_INFO);
        idINFO.color = c_red;
        idINFO.padre = obj_pj.id;
        idINFO.texto = "¡Tu mascota murió!";
        
    }    
    
}

// Respawn

if (roomInicial == room && salud <= 0) {

    var multX = 16;
    var multY = 16;
    var xNuevo = 0;
    var yNuevo = 0;
    
    do {
    
        xNuevo = multX * floor(random_range(2, room_width / multX - TILE_SIZE));
        yNuevo = multY * floor(random_range(1, room_height / multY - TILE_SIZE));
        var tile = tile_layer_find(TILE_LAYER_GRASS, xNuevo, yNuevo);
    
    } until (
    xNuevo % 16 == 0 &&
    yNuevo % 16 == 0 &&
    xNuevo % TILE_SIZE != 0 &&
    yNuevo % TILE_SIZE != 0 &&
    tile != -1 && 
    instance_position(xNuevo, yNuevo - 16, obj_pj) == noone &&
    instance_position(xNuevo, yNuevo - 16, obj_bloque_basic) == noone && 
    instance_position(xNuevo, yNuevo - 16, obj_bloque) == noone && 
    instance_position(xNuevo, yNuevo - 16, obj_telep) == noone && 
    instance_position(xNuevo, yNuevo - 16, obj_npc_basic) == noone
    );
    
    instance_create_depth(xNuevo, yNuevo, 0, object_index);

}




