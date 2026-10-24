/// @description  Ataque a PJ

if (obj_pj.invisible) {
    
	// Si es invisible
            
	ataca = false;
    
	if (!obj_pj.muerto && !paralizado) {
            
	    switch (direccion) {
	        case 0:
	            if (place_meeting(x, y + TILE_SIZE, obj_pj)) {
	                ataca = true;
	            }
	            break;
	        case 1:
	            if (place_meeting(x, y - TILE_SIZE, obj_pj)) {
	                ataca = true;
	            }
	            break;
	        case 2:
	            if (place_meeting(x - TILE_SIZE, y, obj_pj)) {
	                ataca = true;
	            }
	            break;
	        case 3:
	            if (place_meeting(x + TILE_SIZE, y, obj_pj)) {
	                ataca = true;
	            }
	            break;
	    }
        
	}
        
	// Blanco para mascotas / invocaciones
                
	if (ataca) {
	    for (var i = 0; i < 3; i++) {
	        if (obj_pj.criaturasHijas[i, 0] != -1) {
	            with (obj_pj.criaturasHijas[i, 0]) {
	                targetNPC = other.id;
	            }
	        }
	        if (obj_pj.criaturasInvocadas[i] != -1) {
	            with (obj_pj.criaturasInvocadas[i]) {
	                targetNPC = other.id;
	            }
	        }
	    }
	}
        
	// Evasion escudo
        
	if (ataca) {
        
	    if (obj_pj.escudoEnInv != -1 && obj_pj.escudoActual != -1) {
            
	        var chancesEscudos = 0;
                                        
	        if (obj_pj.skills[6] >= 0 && obj_pj.skills[6] <= 10) {
	            chancesEscudos = 9;
	        } else if (obj_pj.skills[6] >= 11 && obj_pj.skills[6] <= 20) {
	            chancesEscudos = 8.85;
	        }  else if (obj_pj.skills[6] >= 21 && obj_pj.skills[6] <= 30) {
	            chancesEscudos = 8.75;
	        }  else if (obj_pj.skills[6] >= 31 && obj_pj.skills[6] <= 40) {
	            chancesEscudos = 8.55;
	        }  else if (obj_pj.skills[6] >= 41 && obj_pj.skills[6] <= 50) {
	            chancesEscudos = 8.35;
	        }  else if (obj_pj.skills[6] >= 51 && obj_pj.skills[6] <= 60) {
	            chancesEscudos = 8.20;
	        }  else if (obj_pj.skills[6] >= 61 && obj_pj.skills[6] <= 70) {
	            chancesEscudos = 8.10;
	        }  else if (obj_pj.skills[6] >= 71 && obj_pj.skills[6] <= 80) {
	            chancesEscudos = 8;
	        }  else if (obj_pj.skills[6] >= 81 && obj_pj.skills[6] <= 90) {
	            chancesEscudos = 7.5;
	        }  else if (obj_pj.skills[6] >= 91 && obj_pj.skills[6] <= 100) {
	            chancesEscudos = 7.25;
	        } 
            
	        chancesEscudos += evasion * 0.01;
                
	        var modAgilidadParaEscu = obtenerAtributoAgilidadPJ() / 22;
                
	        chancesEscudos -= modAgilidadParaEscu;
	        chancesEscudos -= obj_pj.modEvasionEscu;
                
	        if (random(10) > chancesEscudos) {
                
	            ataca = false;
                    
	            var idINFO = instance_create_depth(obj_pj.x, obj_pj.y, 0, obj_INFO);
	            idINFO.padre = obj_pj.id;
	            idINFO.texto = "¡Defendido con escudo!";
	            idINFO.color = c_red;
                
	            reproducirSonido(snd_defensaEscudo, false, false);
                        
	            if (obj_pj.skills[6] < obj_pj.skillsNaturales[obj_pj.nivel]) {
	                intentarSubirSkillNatural(6, 0.5);
	            }
                    
	        }
            
	    }
        
	}
        
	// Evasion
        
	if (ataca) {
        
	    var chancesTacticas = 0;
                                    
	    if (obj_pj.skills[1] >= 0 && obj_pj.skills[1] <= 10) {
	        chancesTacticas = 9;
	    } else if (obj_pj.skills[1] >= 11 && obj_pj.skills[1] <= 20) {
	        chancesTacticas = 8.85;
	    }  else if (obj_pj.skills[1] >= 21 && obj_pj.skills[1] <= 30) {
	        chancesTacticas = 8.75;
	    }  else if (obj_pj.skills[1] >= 31 && obj_pj.skills[1] <= 40) {
	        chancesTacticas = 8.55;
	    }  else if (obj_pj.skills[1] >= 41 && obj_pj.skills[1] <= 50) {
	        chancesTacticas = 8.35;
	    }  else if (obj_pj.skills[1] >= 51 && obj_pj.skills[1] <= 60) {
	        chancesTacticas = 8.20;
	    }  else if (obj_pj.skills[1] >= 61 && obj_pj.skills[1] <= 70) {
	        chancesTacticas = 8.10;
	    }  else if (obj_pj.skills[1] >= 71 && obj_pj.skills[1] <= 80) {
	        chancesTacticas = 8;
	    }  else if (obj_pj.skills[1] >= 81 && obj_pj.skills[1] <= 90) {
	        chancesTacticas = 7.5;
	    }  else if (obj_pj.skills[1] >= 91 && obj_pj.skills[1] <= 100) {
	        chancesTacticas = 7.25;
	    } 
            
	    chancesTacticas += evasion * 0.01;
            
	    var modAgilidadParaTacticas = obtenerAtributoAgilidadPJ() / 22;
            
	    chancesTacticas -= modAgilidadParaTacticas;
	    chancesTacticas -= obj_pj.modEvasion;
            
	    if (random(10) > chancesTacticas) {
            
	        ataca = false;
                
	        var idINFO = instance_create_depth(x, y + 9, 0, obj_INFO);
	        idINFO.padre = id;
	        idINFO.texto = "¡Falla!";
	        idINFO.color = c_red;
                
	        if (obj_pj.skills[1] < obj_pj.skillsNaturales[obj_pj.nivel]) {
	            intentarSubirSkillNatural(1, 0.5);
	        }
                
	    }
        
	}
        
	if (ataca) {
        
	    var dano = round(random_range(danoMeleeMin, danoMeleeMax));
	    var danoTotal = calcularDanoFisicoNPC(dano);

		daniarPj(danoTotal, envenena);
			
	}

}

if (target == -1 || target == obj_pj) {
		
    if (!obj_pj.invisible) {
    
        // Si no es invisible
    
        if (
        !obj_pj.muerto &&
        (x >= global.render_x && (x <= global.render_x + get_render_width())) &&
        (y >= global.render_y && (y <= global.render_y + get_render_height()))
        ) {
    
            if (!paralizado) {
            
                var valido = false;
            
                if (inmovilizado) {
                    switch (direccion) {
                        case 0:
                            if (
                            (obj_pj.x >= x - 16 && obj_pj.x <= x + 16) && 
                            obj_pj.y > y
                            ) {
                                valido = true;
                            }
                            break;
                        case 1:
                            if (
                            (obj_pj.x >= x - 16 && obj_pj.x <= x + 16) && 
                            obj_pj.y < y
                            ) {
                                valido = true;
                            }
                            break;
                        case 2:
                            if (
                            (obj_pj.y >= y - 16 && obj_pj.y <= y + 16) && 
                            obj_pj.x < x
                            ) {
                                valido = true;
                            }
                            break;
                        case 3:
                            if (
                            (obj_pj.y >= y - 16 && obj_pj.y <= y + 16) && 
                            obj_pj.x > x
                            ) {
                                valido = true;
                            }
                            break;
                    }
                    
                } else {
                    valido = true;
                }
                
                if (valido) {
                    var idHechizo = instance_create_depth(obj_pj.x, obj_pj.y, 0, objHechizo);
                    idHechizo.padre = obj_pj.id;
                    
                    var dano = floor(random_range(danoHechizoMin, danoHechizoMax));
                    var danoTotal = calcularDanoMagicoNPC(dano);
                        
                    intentarSubirSkillNatural(17, 0.35);
                        
						daniarPj(danoTotal, envenena);
                    
                }
                
            }
        
        }
    
    }

}

/// Ataque a Persona

if (target != -1 && target != obj_pj && personaRoom != -1 && instance_exists(personaRoom)) {

    if (
    !personaRoom.muerto &&
    (personaRoom.x >= global.render_x && (personaRoom.x <= global.render_x + get_render_width())) &&
    (personaRoom.y >= global.render_y && (personaRoom.y <= global.render_y + get_render_height()))
    ) {
    
        // Si la IA está viva y está dentro de la view (Para que no muera constantemente OOV y queden los ítems tirados)
        
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
        distanciaX <= get_render_width() * 0.5 &&
        distanciaY <= get_render_height() * 0.5
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
                    var idHechizo = instance_create_depth(personaRoom.x, personaRoom.y, 0, objHechizo);
                    idHechizo.padre = personaRoom.id;
                    
                    var dano = floor(random_range(danoHechizoMin, danoHechizoMax));
                    var danoTotal = calcularDanoMagicoNPCaIA(dano, personaRoom);
                    idDano = crearTextoDano(personaRoom.x, personaRoom.y - 41, danoTotal, personaRoom.id);
                    
                    reproducirSonido(sndHechizo, false, false);
                    personaRoom.salud -= danoTotal;
                }
                
            }
        
        }
    
    }

}

alarm[2] = intervaloAtaque;