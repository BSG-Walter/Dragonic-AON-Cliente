/// @description  reproducirSonido(sonido, loop, forzar)
/// @param sonido
/// @param  loop
/// @param  forzar
function reproducirSonido(argument0, argument1, argument2) {

	var indiceSnd = -1; 
        
	if ((obj_opcion_sonido.sonidoActivado || argument2) && instance_number(obj_pausa) == 0) {

	    var valido = true;
    
	    if (
	    object_index != obj_inventario && 
	    object_index != obj_pj && 
	    object_index != obj_control_musica &&
	    object_index != obj_sonido_mar &&
	    object_index != obj_flecha_arriba &&
	    object_index != obj_flecha_abajo &&
	    object_index != obj_flecha_izq &&
	    object_index != obj_flecha_der &&
	    argument0 != snd_tirarDados &&
	    argument0 != snd_subirNivel &&
	    argument0 != snd_resucitar
	    ) {
    
	        if (x < global.render_x - get_render_width() * 0.25 || x > global.render_x + get_render_width() + get_render_width() * 0.25) {
	            valido = false;
	        }
        
	        if (y < global.render_y - get_render_height() * 0.25 || y > global.render_y + get_render_height() + get_render_height() * 0.25) {
	            valido = false;
	        }
        
	    }    
    
	    if (valido) {
	        indiceSnd = audio_play_sound(argument0, 0, argument1);
            if (online_activo() && instance_exists(obj_online) && obj_online.test_role != "" && indiceSnd >= 0) obj_online.audio_events++;
	        if (argument0 == snd_paso || argument0 == snd_barca) {
	            audio_sound_gain(indiceSnd, 0.5, 0);
	        }
	    }    
    
	}

	return indiceSnd;



}
