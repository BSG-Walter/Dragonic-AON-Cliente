/// @description  Actualiza

// Al entrar online por primera vez, esta instancia persistente puede recibir
// Room Start antes de que obj_online cree los controles del PJ y del mapa.
// No acceder a esos objetos hasta que existan.
if (instance_number(obj_pausa) == 0 && is_ingame_room()
    && instance_exists(obj_pj) && instance_exists(obj_mapas_mundo)) {

    if (opcionAnimacionAgua) {
    
        if (opcionPeces) {
            with (obj_pez) {
                instance_destroy();
            }
        }
    
        alarm[0] = 1;
        
    }
    
    if (opcionParticulas) {
        with (obj_particula) {
            instance_destroy();
        }
		if (sonidoLluvia != -1) { 
			if (esMapaDescubierto())
				audio_resume_sound(sonidoLluvia);
			else
				audio_pause_sound(sonidoLluvia);
		}
		cantidadGotasDeLluvia = instance_number(obj_lluvia);
        with (obj_lluvia) {
            instance_destroy();
        }
        with (obj_salpicadura) {
            instance_destroy();
        }
        alarm[0] = 1;
    }
    
    if (opcionNubes) {
        with (obj_nubes) {
            instance_destroy();
        }
        alarm[0] = 1;
    }
    
    // Durante la exportacion online conservar los arboles aunque se optimicen ciudades al jugar.
    if (opcionOptimizarCiudades && !global.online_exportando && obj_mapas_mundo.mapas[room]) {
        optimizarCiudad();
    }
    
}

