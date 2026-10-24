if (online_activo()) exit;
/// @description  Tira hechizos si el PJ es PK

if (obj_pj.pk && !obj_pj.invisible && !obj_pj.muerto) {
    if (
    (x >= global.render_x && (x <= global.render_x + get_render_width())) &&
    (y >= global.render_y && (y <= global.render_y + get_render_height()))
    ) {
    
        var dano = floor(random_range(87, 98));
    
        var idEfectoHechizo = instance_create_depth(obj_pj.x, obj_pj.y, 0, obj_apocalipsis);
        idEfectoHechizo.padre = obj_pj.id;
        
        var danoTotal = calcularDanoMagicoNPC(dano);
                                
        var idDano = crearTextoDano(obj_pj.x, obj_pj.y, danoTotal, obj_pj.id);
        
        var idMsg = instance_create_depth(x, y, 0, obj_msg);
        idMsg.desc = desc2;
        idMsg.tiempo = 150;
        
        reproducirSonido(snd_apocalipsis, false, false);
        vibrarPantalla();
        
        if (obj_pj.salud - danoTotal > 0) {
            obj_pj.salud -= danoTotal;
        } else {
            muertePJ();
        }
        
        if (obj_pj.puntosPK != -1) {
            obj_pj.puntosPK--;
            if (obj_pj.puntosPK == 0) {
                obj_pj.pk = false;
                with (obj_persona) {
                    if (agitando) {
                        agitando = false;
                        enemigo = false;
                        yaHablo = false;
                        tiempoLejosPJ = 0;
                        tiempoEnView = 0;
                        yaHabloEnojado1 = false;
                        yaHabloEnojado2 = false;
                        yaHabloEnojado3 = false;
                    }
                }
            }
        }
        
    }
}

if (instance_number(obj_persona) > 0 && !obj_persona.muerto && obj_persona.pk) {
    
    if (
    (obj_persona.x >= global.render_x && (obj_persona.x <= global.render_x + get_render_width())) &&
    (obj_persona.y >= global.render_y && (obj_persona.y <= global.render_y + get_render_height()))
    ) {
    
        // Si la IA está viva y está dentro de la view (Para que no muera constantemente OOV y queden los ítems tirados)
        
        var distanciaX = 0;
        var distanciaY = 0; 
        
        if (x > obj_persona.x) {
            distanciaX = x - obj_persona.x;
        } else if (x < obj_persona.x) {
            distanciaX = obj_persona.x - x;
        }
        
        if (y > obj_persona.y) {
            distanciaY = y - obj_persona.y;
        } else if (y < obj_persona.y) {
            distanciaY = obj_persona.y - y;
        }
        
        if (
        distanciaX <= get_render_width() * 0.5 &&
        distanciaY <= get_render_height() * 0.5
        ) {
            
            var idHechizo = instance_create_depth(obj_persona.x, obj_persona.y, 0, obj_apocalipsis);
            idHechizo.padre = obj_persona.id;
            
            var dano = floor(random_range(87, 98));
            var danoTotal = calcularDanoMagicoNPCaIA(dano, obj_persona.id);
            idDano = crearTextoDano(obj_persona.x, obj_persona.y - 41, danoTotal, obj_persona.id);
            
            reproducirSonido(snd_apocalipsis, false, false);
            obj_persona.salud -= danoTotal;
        
        }
        
    }
    
}

alarm[3] = 300;

