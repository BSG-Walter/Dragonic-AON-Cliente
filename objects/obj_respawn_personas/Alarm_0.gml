if (online_activo() || global.online_exportando) exit;
/// @description  Spawn

var rand = 2.5;

if (random(10) > rand) {
    
    if (is_ingame_room() && !is_special_room()) {
    
        var repetir = irandom_range(2, 4);
        
        repeat (repetir) {
        
            var puedeCrear = false;
            var i = 0;
            while (i < obj_personas_mundo.totalMultiIA) {
                var _slot = obj_personas_mundo.globalIA[i];
                if (_slot.x == -1) {
                    puedeCrear = true;
                    break;
                }
                i++;
            }
            
            if (puedeCrear) {
    
                var multX = 16;
                var multY = 16;
                var xNuevo = 0;
                var yNuevo = 0;
                
				//aca se genera un loop infinito si estas dentro del lugar para enlistarte a la armada, probablemente por el tema de que cambia los tiles a negros.
				//asi que le puse un limite a ese lop
				
				var limite_intentos = 1000
                do {
                
                    xNuevo = multX * floor(random_range(2, room_width / multX - TILE_SIZE));
                    yNuevo = multY * floor(random_range(1, room_height / multY - TILE_SIZE));
                    
                    var tile = tile_layer_find(TILE_LAYER_GRASS, xNuevo, yNuevo);
                    
                    if (obj_pj.nivel >= 25) {
                        tile = 1;
                    }
					
					limite_intentos--
					if (limite_intentos < 0) exit;
                
                } until (
                xNuevo % 16 == 0 &&
                yNuevo % 16 == 0 &&
                xNuevo % TILE_SIZE != 0 &&
                yNuevo % TILE_SIZE != 0 &&
                tile != -1 && 
                posicionLejosDePJ(xNuevo, yNuevo - 16) && 
                // instance_position(xNuevo, yNuevo - 16, obj_pj) == noone &&
                instance_position(xNuevo, yNuevo - 16, obj_bloque_basic) == noone && 
                instance_position(xNuevo, yNuevo - 16, obj_bloque) == noone && 
                instance_position(xNuevo, yNuevo - 16, obj_telep) == noone && 
                instance_position(xNuevo, yNuevo - 16, obj_npc_basic) == noone
                );
                
                var idPersona = instance_create_depth(xNuevo, yNuevo, 0, obj_persona);
                
                var idEfecto = instance_create_depth(idPersona.x, idPersona.y, 0, obj_efecto_login);
                idEfecto.padre = idPersona;
                with (idPersona) {
                    guardarDatosIAEnGlobalIA();
                    reproducirSonido(snd_logueo, false, false);
                }
            
            }
            
        }
        
    }

}

if (obj_control_opciones.simularHorarios) {

    // Actualiza los intervalos según la hora
    
    var hora = current_hour;
    
    if (hora >= 1 && hora < 3) {
        intervaloMin = 10800;
    } else if (hora >= 3 && hora < 5) {
        intervaloMin = 14400;
    } else if (hora >= 5 && hora < 8) {
        intervaloMin = 18000;
    } else if (hora >= 8 && hora < 12) {
        intervaloMin = 14400;
    } else if (hora >= 12 && hora < 14) {
        intervaloMin = 10800;
    } else if (hora >= 14 && hora < 16) {
        intervaloMin = 7200;
    } else if (hora >= 16 && hora < 19) {
        intervaloMin = 3600;
    } else if (hora >= 19 && hora < 21) {
        intervaloMin = 7200;
    } else if ((hora >= 21) || (hora >= 0 && hora < 1)) {
        intervaloMin = 10800;
    }
    
} else {
    intervaloMin = 8000;
}
    
if (is_ingame_room() && !is_special_room()) {
    intervaloMin = intervaloMin / setearIntervaloCreacionIA(room);
}

intervaloMin-= (intervaloMin*(obj_pj.nivel/obj_pj.nivelMax))*0.5
intervaloMax = intervaloMin + intervaloMin / 2.5;

alarm[0] = floor(random_range(intervaloMin, intervaloMax));





