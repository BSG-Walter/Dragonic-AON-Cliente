/// @description  reproducirPaso(navegando)
/// @param navegando
function reproducirPaso(argument0) {

	var sndPaso;

	if (!argument0) {
	    sndPaso = snd_paso;
	} else {
	    sndPaso = snd_barca;
	}

	if (!inmovilizado && !muerto && (x != xObjetivo || y != yObjetivo)) {
	    switch (direccion) {
	        case 0:
	            if (
	            !place_meeting(x, y + TILE_SIZE, obj_bloque_basic) &&
	            !place_meeting(x, y + TILE_SIZE, obj_npc_basic) &&
	            !place_meeting(x, y + TILE_SIZE, obj_telep) &&
	            !place_meeting(x, y + TILE_SIZE, obj_pj) 
	            ) {
	                reproducirSonido(sndPaso, false, false);
	            }
	            break;
	        case 1:
	            if (
	            !place_meeting(x, y - TILE_SIZE, obj_bloque_basic) &&
	            !place_meeting(x, y - TILE_SIZE, obj_npc_basic) &&
	            !place_meeting(x, y - TILE_SIZE, obj_telep) &&
	            !place_meeting(x, y - TILE_SIZE, obj_pj) 
	            ) {
	                reproducirSonido(sndPaso, false, false);
	            }
	            break;
	        case 2:
	            if (
	            !place_meeting(x - TILE_SIZE, y, obj_bloque_basic) &&
	            !place_meeting(x - TILE_SIZE, y, obj_npc_basic) &&
	            !place_meeting(x - TILE_SIZE, y, obj_telep) &&
	            !place_meeting(x - TILE_SIZE, y, obj_pj) 
	            ) {
	                reproducirSonido(sndPaso, false, false);
	            }
	            break;
	        case 3:
	            if (
	            !place_meeting(x + TILE_SIZE, y, obj_bloque_basic) &&
	            !place_meeting(x + TILE_SIZE, y, obj_npc_basic) &&
	            !place_meeting(x + TILE_SIZE, y, obj_telep) &&
	            !place_meeting(x + TILE_SIZE, y, obj_pj) 
	            ) {
	                reproducirSonido(sndPaso, false, false);
	            }
	            break;
	    }
	}



}
