/// @description  Ataque a Persona

if (personaRoom != -1 && instance_exists(personaRoom)) {

    if (
    personaRoom.enemigo &&
    !personaRoom.muerto &&
    (personaRoom.x >= global.render_x && (personaRoom.x <= global.render_x + get_render_width())) &&
    (personaRoom.y >= global.render_y && (personaRoom.y <= global.render_y + get_render_height()))
    ) {
    
        // Si la IA está viva y está dentro de la view
        
        var distanciaX = 0;
        var distanciaY = 0; 
        
        if (x > personaRoom.x) {
            distanciaX = x - personaRoom.x;
        } else if (x < personaRoom.x) {
            distanciaX = personaRoom.x - x;
        }
        
        if (y > personaRoom.y) {
            distanciaY = y - personaRoom.y;
        } else if (y < personaRoom.y) {
            distanciaY = personaRoom.y - y;
        }
        
        if (
        distanciaX <= (global.render_x + get_render_width()) * 0.5 &&
        distanciaY <= (global.render_y + get_render_height()) * 0.5
        ) {
        
            if (!paralizado) {
        
                var valido = false;
            
                if (inmovilizado) {
                    switch (direccion) {
                        case 0:
                            if (
                            (personaRoom.x >= x - 16 && personaRoom.x <= x + 16) && 
                            personaRoom.y > y
                            ) {
                                valido = true;
                            }
                            break;
                        case 1:
                            if (
                            (personaRoom.x >= x - 16 && personaRoom.x <= x + 16) && 
                            personaRoom.y < y
                            ) {
                                valido = true;
                            }
                            break;
                        case 2:
                            if (
                            (personaRoom.y >= y - 16 && personaRoom.y <= y + 16) && 
                            personaRoom.x < x
                            ) {
                                valido = true;
                            }
                            break;
                        case 3:
                            if (
                            (personaRoom.y >= y - 16 && personaRoom.y <= y + 16) && 
                            personaRoom.x > x
                            ) {
                                valido = true;
                            }
                            break;
                    }
                    
                } else {
                    valido = true;
                }
                
                if (valido) {
                    var idHechizo = instance_create_depth(personaRoom.x, personaRoom.y, 0, obj_tormenta_de_fuego);
                    idHechizo.padre = personaRoom.id;
                    
                    var dano = floor(random_range(danoHechizoMin, danoHechizoMax));
                    var danoTotal = calcularDanoMagicoNPCaIA(dano, personaRoom);
                    idDano = crearTextoDano(personaRoom.x, personaRoom.y - 41, danoTotal, personaRoom.id);
                    
					// Palabras mágicas
        
			        dicePalabrasMagicas = true;
			        palabrasMagicas = "EN VAX ON TAR";
			        alarm[9] = 180;
					
                    reproducirSonido(snd_tormentaDeFuego, false, false);
                    personaRoom.salud -= danoTotal;
                    
                    if (personaRoom.salud <= 0 && !is_special_room()) {
                        if (personaRoom.pk) {
                            obj_pj.criminalesMatados++;
                        } else {
                            obj_pj.puntosPK = -1;
                            obj_pj.ciudadanosMatados++;
                        }
                    }
                    
                }
                
            }
        
        }
    
    }

}

alarm[2] = floor(random_range(intervaloAtaque * 0.85, intervaloAtaque * 1.15));

