/// @description  Cambio el alpha del agua

if (instance_number(obj_pausa) == 0 && is_ingame_room() && instance_exists(obj_pj)) {

    if (opcionAnimacionAgua) {
    
        var lay = layer_get_id("Background_Agua");
        if (lay != -1) {
            var bg = layer_background_get_id(lay);
            if (bg != -1) {
                layer_background_sprite(bg, bck_agua_2);
            }
        }
        if (instance_exists(obj_control_animacion_agua))
            obj_control_animacion_agua.alarm[0] = 300;
    
        if (opcionPeces) {
            repeat(5) {
                instance_create_depth(global.render_x + random(get_render_width()), global.render_y + random(get_render_height()), 0, obj_pez);
            }
        }
        
    }
    
    if (opcionParticulas) {
        repeat(25) {
            instance_create_depth(global.render_x + random(get_render_width()), global.render_y + random(get_render_height()), 0, obj_particula);
        }
		if (obj_pj.direccion == 1)
			crearLluvia(cantidadGotasDeLluvia, 0, 140);
		else if (obj_pj.direccion == 2 || obj_pj.direccion == 3)
			crearLluvia(cantidadGotasDeLluvia, 300, 140);
		else
			crearLluvia(cantidadGotasDeLluvia, 0, 0);
			
    }
    
    if (opcionNubes) {
        instance_create_depth(0, 0, 0, obj_nubes);
    }

}

