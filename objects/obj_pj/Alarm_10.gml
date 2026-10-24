if (online_activo()) exit;
/// @description  Checkea si el jugador quedo encerrado al morir

if (muerto) {

        encerrado = false;

        var bloqueoDer = false;
        var bloqueoIzq = false;
        var bloqueoAbajo = false;
        var bloqueoArriba = false;

        if (!navega) {
            bloqueoDer = place_meeting(x + TILE_SIZE, y, obj_bloqueo_agua);
            bloqueoIzq = place_meeting(x - TILE_SIZE, y, obj_bloqueo_agua);
            bloqueoAbajo = place_meeting(x, y + TILE_SIZE, obj_bloqueo_agua);
            bloqueoArriba = place_meeting(x, y - TILE_SIZE, obj_bloqueo_agua);
        } else {
            bloqueoDer = place_meeting(x + TILE_SIZE, y, obj_bloqueo_tierra);
            bloqueoIzq = place_meeting(x - TILE_SIZE, y, obj_bloqueo_tierra);
            bloqueoAbajo = place_meeting(x, y + TILE_SIZE, obj_bloqueo_tierra);
            bloqueoArriba = place_meeting(x, y - TILE_SIZE, obj_bloqueo_tierra);
        }
        
        if (
        (place_meeting(x + TILE_SIZE, y, obj_bloque_basic) ||
        place_meeting(x + TILE_SIZE, y, obj_npc_basic) || 
        bloqueoDer) &&
        (place_meeting(x - TILE_SIZE, y, obj_bloque_basic) || 
        place_meeting(x - TILE_SIZE, y, obj_npc_basic) || 
        bloqueoIzq) &&
        (place_meeting(x, y + TILE_SIZE, obj_bloque_basic) || 
        place_meeting(x, y + TILE_SIZE, obj_npc_basic) || 
        bloqueoAbajo) &&
        (place_meeting(x, y - TILE_SIZE, obj_bloque_basic) || 
        place_meeting(x, y - TILE_SIZE, obj_npc_basic) ||
        bloqueoArriba)
        ) {
            encerrado = true;
        }
        
        if (encerrado) {
            alarm[9] = 180;
        }
        
}

