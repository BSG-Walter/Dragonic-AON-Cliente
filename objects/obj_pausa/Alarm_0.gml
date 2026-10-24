/// @description  Opciones

if (
(mouse_x >= get_render_x() + 229 && mouse_x <= get_render_x() + 357) &&
(mouse_y >= get_render_y() + 315 && mouse_y <= get_render_y() + 346)
) {

    // Guardar partida
    
    if (!IACerca && nombrePJ != "RESTAURAR_PERSONAJE") {
        if (online_activo()) {
            dibuja = false;
            if (!guardarPartida(nombrePJ)) {
                dibuja = true;
                pudoGuardar = false;
                alarm[1] = 80;
            }
        } else if (guardarPartida(nombrePJ)) {
            dibuja = true;
            pudoGuardar = true;
            alarm[1] = 80;
            alarm[2] = 10;
        } else {
            dibuja = true;
            pudoGuardar = false;
            alarm[1] = 80;
        }
    } else {
        dibuja = true;
        pudoGuardar = false;
        alarm[1] = 80;
        if (online_activo() && instance_exists(obj_online) && obj_online.save_state != 1) {
            obj_online.save_sequence = 0;
            online_guardado_estado(3, IACerca
                ? "No podés guardar la partida habiendo enemigos cerca tuyo"
                : "No se pudo guardar la partida");
            dibuja = false;
        }
    }

} else if (
(mouse_x >= get_render_x() + 409 && mouse_x <= get_render_x() + 537) &&
(mouse_y >= get_render_y() + 315 && mouse_y <= get_render_y() + 346)
) {

    if (online_activo()) { online_volver_menu(); exit; }
    // Menú principal
    
    audio_stop_all();
    
    with (all) {
        if (
        object_index != obj_pausa && object_index != obj_online &&
        object_index != obj_opciones && 
        object_index != obj_control_vista &&
        object_index != obj_control_opciones &&
        object_index != obj_control_devices &&
        object_index != obj_control_musica &&
        object_index != obj_sonido_mar &&
        object_index != obj_opcion_sonido &&
        object_index != obj_opcion_musica &&
        object_index != obj_control_notificacion_torneos
        ) {
            instance_deactivate_object(self);
        }
    }
    
    with (obj_borde_mapa) {
        instance_destroy();
    }
    
    with (obj_nubes) {
        instance_destroy();
    }       
        
    obj_control_musica.indxMusicaAnterior = -1;
	obj_opciones.lloviendo = false;
    
    room_goto(rm_menuPrincipal);
    
} else if (
(mouse_x >= get_render_x() + 326 && mouse_x <= get_render_x() + 503) &&
(mouse_y >= get_render_y() + 95 && mouse_y <= get_render_y() + 302)
) {

    // Mapa
    
    if (!roomDesconocida) {
        
        var xInicioMapa = get_render_x() + 326;
        var yInicioMapa = get_render_y() + 95;
        
        var coordX;
        var coordY;
        
        if (mouse_x >= xInicioMapa && mouse_x < xInicioMapa + 14.75) {
            coordX = 0;    
        } else if (mouse_x >= xInicioMapa + 14.75 && mouse_x < xInicioMapa + 14.75 * 2) {
            coordX = 1;    
        } else if (mouse_x >= xInicioMapa + 14.75 * 2 && mouse_x < xInicioMapa + 14.75 * 3) {
            coordX = 2;    
        } else if (mouse_x >= xInicioMapa + 14.75 * 3 && mouse_x < xInicioMapa + 14.75 * 4) {
            coordX = 3;    
        } else if (mouse_x >= xInicioMapa + 14.75 * 4 && mouse_x < xInicioMapa + 14.75 * 5) {
            coordX = 4;    
        } else if (mouse_x >= xInicioMapa + 14.75 * 5 && mouse_x < xInicioMapa + 14.75 * 6) {
            coordX = 5;    
        } else if (mouse_x >= xInicioMapa + 14.75 * 6 && mouse_x < xInicioMapa + 14.75 * 7) {
            coordX = 6;    
        } else if (mouse_x >= xInicioMapa + 14.75 * 7 && mouse_x < xInicioMapa + 14.75 * 8) {
            coordX = 7;    
        } else if (mouse_x >= xInicioMapa + 14.75 * 8 && mouse_x < xInicioMapa + 14.75 * 9) {
            coordX = 8;    
        } else if (mouse_x >= xInicioMapa + 14.75 * 9 && mouse_x < xInicioMapa + 14.75 * 10) {
            coordX = 9;    
        } else if (mouse_x >= xInicioMapa + 14.75 * 10 && mouse_x < xInicioMapa + 14.75 * 11) {
            coordX = 10;    
        } else if (mouse_x >= xInicioMapa + 14.75 * 11) {
            coordX = 11;    
        }
        
        if (mouse_y >= yInicioMapa && mouse_y < yInicioMapa + 17.25) {
            coordY = 0;    
        } else if (mouse_y >= yInicioMapa + 17.25 && mouse_y < yInicioMapa + 17.25 * 2) {
            coordY = 1;    
        } else if (mouse_y >= yInicioMapa + 17.25 * 2 && mouse_y < yInicioMapa + 17.25 * 3) {
            coordY = 2;    
        } else if (mouse_y >= yInicioMapa + 17.25 * 3 && mouse_y < yInicioMapa + 17.25 * 4) {
            coordY = 3;    
        } else if (mouse_y >= yInicioMapa + 17.25 * 4 && mouse_y < yInicioMapa + 17.25 * 5) {
            coordY = 4;    
        } else if (mouse_y >= yInicioMapa + 17.25 * 5 && mouse_y < yInicioMapa + 17.25 * 6) {
            coordY = 5;    
        } else if (mouse_y >= yInicioMapa + 17.25 * 6 && mouse_y < yInicioMapa + 17.25 * 7) {
            coordY = 6;    
        } else if (mouse_y >= yInicioMapa + 17.25 * 7 && mouse_y < yInicioMapa + 17.25 * 8) {
            coordY = 7;    
        } else if (mouse_y >= yInicioMapa + 17.25 * 8 && mouse_y < yInicioMapa + 17.25 * 9) {
            coordY = 8;    
        } else if (mouse_y >= yInicioMapa + 17.25 * 9 && mouse_y < yInicioMapa + 17.25 * 10) {
            coordY = 9;    
        } else if (mouse_y >= yInicioMapa + 17.25 * 10 && mouse_y < yInicioMapa + 17.25 * 11) {
            coordY = 10;   
        } else if (mouse_y >= yInicioMapa + 17.25 * 11) {
            coordY = 11;    
        }
        
        with (obj_borde_mapa) {
            instance_destroy();
        }
        
        instance_create_depth(get_render_x() + 326 + coordX * 14.75, get_render_y() + 95 + coordY * 17.25,
            min(DEPTH_MAP_BORDER, depth - 1), obj_borde_mapa);
        
        nombreMapaPausa = obtenerNombreMapa(matRooms[coordY, coordX], coordY, coordX);
    
    }
    
} else if (
(mouse_x >= get_render_x() + 16 && mouse_x <= get_render_x() + 69) &&
(mouse_y >= get_render_y() + 6 && mouse_y <= get_render_y() + 29)
) {

    // Continúa
    
    if (obj_opcion_musica.musicaActivada)
        audio_resume_all();
    
    with (obj_borde_mapa) {
        instance_destroy();
    }
    
    instance_activate_all();
    
	if (obj_opciones.lloviendo) {
		if (obj_opcion_sonido.sonidoActivado)
			if (obj_opciones.sonidoLluvia != -1 && esMapaDescubierto())
				audio_resume_sound(obj_opciones.sonidoLluvia);
	} else {
		with (obj_lluvia) {
			instance_destroy()
		}
		with (obj_salpicadura) {
			instance_destroy()
		}
	}
	
    with (obj_pj) {
        alinearPJ();
    }
    
    if (obj_opciones.opcionNubes) {
        instance_create_depth(0, 0, 0, obj_nubes);    
    }
    
    instance_destroy();

}


