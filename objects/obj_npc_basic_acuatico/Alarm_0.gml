/// @description  Movimiento en Agua

if (!puedeMoverse || siguiendo) {
    puedeMoverse = true;
    siguiendo = false;
    if (!inmovilizado && !paralizado) {
        switch (direccion) {
            case 0:
                if (
                !place_meeting(x, y + TILE_SIZE, obj_bloque_basic) &&
                !place_meeting(x, y + TILE_SIZE, obj_bloqueo_tierra) &&
                !place_meeting(x, y + TILE_SIZE, obj_npc_basic) &&
                !place_meeting(x, y + TILE_SIZE, obj_telep) &&
                !place_meeting(x, y + TILE_SIZE, obj_pj) 
                ) {
                    reproducirSonido(snd_barca, false, false);
                }
                break;
            case 1:
                if (
                !place_meeting(x, y - TILE_SIZE, obj_bloque_basic) &&
                !place_meeting(x, y - TILE_SIZE, obj_bloqueo_tierra) &&
                !place_meeting(x, y - TILE_SIZE, obj_npc_basic) &&
                !place_meeting(x, y - TILE_SIZE, obj_telep) &&
                !place_meeting(x, y - TILE_SIZE, obj_pj) 
                ) {
                    reproducirSonido(snd_barca, false, false);
                }
                break;
            case 2:
                if (
                !place_meeting(x - TILE_SIZE, y, obj_bloque_basic) &&
                !place_meeting(x - TILE_SIZE, y, obj_bloqueo_tierra) &&
                !place_meeting(x - TILE_SIZE, y, obj_npc_basic) &&
                !place_meeting(x - TILE_SIZE, y, obj_telep) &&
                !place_meeting(x - TILE_SIZE, y, obj_pj) 
                ) {
                    reproducirSonido(snd_barca, false, false);
                }
                break;
            case 3:
                if (
                !place_meeting(x + TILE_SIZE, y, obj_bloque_basic) &&
                !place_meeting(x + TILE_SIZE, y, obj_bloqueo_tierra) &&
                !place_meeting(x + TILE_SIZE, y, obj_npc_basic) &&
                !place_meeting(x + TILE_SIZE, y, obj_telep) &&
                !place_meeting(x + TILE_SIZE, y, obj_pj) 
                ) {
                    reproducirSonido(snd_barca, false, false);
                }
                break;
        }
    }
}


