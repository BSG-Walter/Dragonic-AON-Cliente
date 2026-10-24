// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function usarItem(){
if (online_activo()) { online_usar(); return; }
with(obj_inventario){
	if (seleccionado != -1) {

	    for (var i = 0; i < maximoInv; i++) {
	        if (seleccionado == slots[i].indice) {
	            break;
	        }
	    }

	    if (obj_pj.muerto && slots[i].tipo != "barca" && slots[i].tipo != "runa") {
	        exit;
	    }
    
	    if (slots[i].tipo == "arma") {
	        if (obj_pj.armaActual >= 21 && obj_pj.armaActual <= 27) {
	            if (obj_pj.puedeAtacar && obj_pj.energia >= 20 && obj_pj.flechaEnInv != -1) {
	                obj_pj.atacaConArco = true;
	            }
	        }
	    } else if (slots[i].tipo == "comida") {
    
	        var suma = 0;
        
	        switch (slots[i].indice) {
	            case 101:
	                suma = 10;
	                break;
	            case 102:
	                suma = 15;
	                break;
	            case 103:
	                suma = 15;
	                break;
	            case 104:
	                suma = 20;
	                break;
	            case 105:
	                suma = 20;
	                break;
	            case 106:
	                suma = 25;
	                break;
	            case 107:
	                suma = 75;
	                break;
	            case 108:
	                suma = 50;
	                break;
	            case 109:
	                suma = 50;
	                break;
	            case 110:
	                suma = 25;
	                break;
	            case 111:
	                suma = 50;
	                break;
	            case 112:
	                suma = 75;
	                break;
	            case 113:
	                suma = 75;
	                break;
	            case 114:
	                suma = 75;
	                break;
	            case 115:
	                suma = 100;
	                break;
	        }
        
	        reproducirSonido(snd_comerComida, false, false);
    
	        if (obj_pj.hambre + suma <= obj_pj.hambreMax) {
	            obj_pj.hambre += suma;
	        } else {
	            obj_pj.hambre = obj_pj.hambreMax;
	        }
        
	        if (slots[i].cant > 1) {
	            slots[i].cant--;
	        } else {
	            slots[i] = crearSlotInv(-1, 0, false);
	            seleccionado = -1;
	        }
        
	    } else if (slots[i].tipo == "bebida") {
    
	        var suma = 0;
        
	        switch (slots[i].indice) {
	            case 116:
	                suma = 30;
	                break;
	            case 117:
	                suma = 60;
	                break;
	            case 118:
	                suma = 90;
	                break;
	            case 119:
	                suma = 100;
	                break;
	        }
        
	        if (obj_pj.sed + suma <= obj_pj.sedMax) {
	            obj_pj.sed += suma;
	        } else {
	            obj_pj.sed = obj_pj.sedMax;
	        }
        
	        reproducirSonido(snd_tomarBebida, false, false);
        
	        if (slots[i].cant > 1) {
	            slots[i].cant--;
	        } else {
	            slots[i] = crearSlotInv(-1, 0, false);
	            seleccionado = -1;
	        }
        
	    } else if (slots[i].tipo == "hechizo") {
        
	        var valido = false;
	        valido = agregarHechizo(slots[i].indice);
    
	        if (valido) {
	            if (slots[i].cant > 1) {
	                slots[i].cant--;
	            } else {
	                slots[i] = crearSlotInv(-1, 0, false);
	                seleccionado = -1;
	            }
	        }
        
	    } else if (slots[i].tipo == "pocion") {
        
	        if (slots[i].indice == 141) {
            
	            var sumaSalud = floor(15 * obj_pj.saludMax / 100);
        
	            if (obj_pj.salud + sumaSalud <= obj_pj.saludMax) {
	                obj_pj.salud += sumaSalud;
	            } else {
	                obj_pj.salud = obj_pj.saludMax;
	            }
            
	        } else if (slots[i].indice == 142) {
        
	            if (obj_pj.manaMax > 0) {
	                var sumaMana = floor(15 * obj_pj.manaMax / 100);
            
	                if (obj_pj.mana + sumaMana <= obj_pj.manaMax) {
	                    obj_pj.mana += sumaMana;
	                } else {
	                    obj_pj.mana = obj_pj.manaMax;
	                }
	            }
            
	        } else if (slots[i].indice == 143) {
        
	            obj_pj.envenenado = false;
	            obj_pj.veneno = 0;
        
	        } else if (slots[i].indice == 218) {
				if (obj_pj.dopaAgilidad < obj_pj.maximoDopa)
					obj_pj.dopaAgilidad++
				obj_pj.tiempoDopa = 0
				alarm[7] = 1
			} else if (slots[i].indice == 219) {
				if (obj_pj.dopaFuerza < obj_pj.maximoDopa)
					obj_pj.dopaFuerza++
				obj_pj.tiempoDopa = 0
				alarm[7] = 1
			} else if (slots[i].indice == 220) {
				if (claseGuerrera()) {
					if (obj_pj.inmovilizado) {
					
						obj_pj.salud -= floor(obj_pj.salud / 3);                   
		                reproducirSonido(snd_dardoMagico, false, false);   
		                obj_pj.inmovilizado = false;
						var idINFO = instance_create_depth(obj_pj.x, obj_pj.y, 0, obj_INFO);
					    idINFO.padre = obj_pj.id;
					    idINFO.color = make_color_rgb(211, 90, 211);
					    idINFO.texto = "¡Removido!"; 
					    idINFO.tiempo = 180;
					
				        reproducirSonido(snd_tomarPocion, false, false);
        
				    if (slots[i].cant > 1) {
					    slots[i].cant--;
				    } else {
					    slots[i] = crearSlotInv(-1, 0, false);
					    seleccionado = -1;
				    }
					
					} else {
						var idINFO = instance_create_depth(obj_pj.x, obj_pj.y, 0, obj_INFO);
		                idINFO.padre = obj_pj.id;
		                idINFO.texto = "¡No estás inmovilizado ni paralizado!"; 
					}
				} else {
					var idINFO = instance_create_depth(obj_pj.x, obj_pj.y, 0, obj_INFO);
	                idINFO.padre = obj_pj.id;
	                idINFO.texto = "¡Tu clase no puede usar este ítem!"; 
				}
			} else if (slots[i].indice == 221) {
				if (claseGuerrera()) {
				
					obj_pj.salud -= floor(obj_pj.salud * 0.9);                   
		            reproducirSonido(snd_dardoMagico, false, false);   
					var idEfectoHechizo = instance_create_depth(obj_pj.x, obj_pj.y, 0, obj_invisibilidad);
					idEfectoHechizo.padre = obj_pj.id;
		            obj_pj.invisible = true;
	                obj_pj.alarm[5] = 1800;
                                                    
	                if (instance_number(obj_persona) > 0) {
	                    with (obj_persona) {
	                        yaHablo = false;
	                    }
	                }
					
				    reproducirSonido(snd_tomarPocion, false, false);
        
				    if (slots[i].cant > 1) {
				        slots[i].cant--;
				    } else {
				        slots[i] = crearSlotInv(-1, 0, false);
				        seleccionado = -1;
				    }
					
				} else {
					var idINFO = instance_create_depth(obj_pj.x, obj_pj.y, 0, obj_INFO);
	                idINFO.padre = obj_pj.id;
	                idINFO.texto = "¡Tu clase no puede usar este ítem!"; 
				}
			}
        
			if (slots[i].indice == 141 || slots[i].indice == 142 || slots[i].indice == 143 || slots[i].indice == 218 || slots[i].indice == 219) {
		        reproducirSonido(snd_tomarPocion, false, false);
        
		        if (slots[i].cant > 1) {
		            slots[i].cant--;
		        } else {
		            slots[i] = crearSlotInv(-1, 0, false);
		            seleccionado = -1;
		        }
			}
        
	    } else if (slots[i].tipo == "barca") {
    
			obj_skills_libres.mostrado = false;
	
	        var idINFO = 0;
    
        if (obj_pj.nivel < NIVEL_MIN_BARCA) {
            idINFO = instance_create_depth(obj_pj.x, obj_pj.y, 0, obj_INFO);
            idINFO.padre = obj_pj.id;
            idINFO.texto = "¡Nivel menor a " + string(NIVEL_MIN_BARCA) + "!";
	        } else if (obj_pj.skills[14] < 70) {
	            idINFO = instance_create_depth(obj_pj.x, obj_pj.y, 0, obj_INFO);
	            idINFO.padre = obj_pj.id;
	            idINFO.texto = "¡Navegación menor a 70!";
	        }
    
	        if (obj_pj.skills[14] >= 70 && obj_pj.nivel >= NIVEL_MIN_BARCA && obj_pj.puedeMoverse) {
	            with (obj_pj) {
	                var _bloqueoDestino = navega ? obj_bloqueo_tierra : obj_bloqueo_agua;
	                var _dx = [0, 0, -TILE_SIZE, TILE_SIZE];
	                var _dy = [TILE_SIZE, -TILE_SIZE, 0, 0];
	                var _x = x + _dx[direccion];
	                var _y = y + _dy[direccion];
	                if (place_meeting(_x, _y, _bloqueoDestino)
	                    && !place_meeting(_x, _y, obj_bloque_basic)
	                    && !place_meeting(_x, _y, obj_npc_basic)) {
	                    navega = !navega;
	                    obj_sonido_mar.inicioPartida = false;
	                    obj_sonido_mar.alarm[0] = 1;
	                    with (obj_numpad) instance_destroy();
	                }
	            }
	        }

	    } else if (slots[i].tipo == "runa") {
        
	        var idINFO = 0;
    
	        if (obj_pj.puedeMoverse) {
        
	            if (!obj_pj.muerto) {
	                idINFO = instance_create_depth(obj_pj.x, obj_pj.y, 0, obj_INFO);
	                idINFO.padre = obj_pj.id;
	                idINFO.texto = "¡Tenés que estar muerto para usar este ítem!";
	            } else {
                
	                if (obj_pj.roomRuna != -1 && obj_pj.xRuna != -1 && obj_pj.yRuna != -1) {
	                    usarRuna();
	                    obj_pj.x = obj_pj.xRuna;
	                    obj_pj.y = obj_pj.yRuna;
	                    obj_pj.alarm[9] = 1;   
	                } else {
	                    idINFO = instance_create_depth(obj_pj.x, obj_pj.y, 0, obj_INFO);
	                    idINFO.padre = obj_pj.id;
	                    idINFO.texto = "¡No tenés asignado un hogar!";
	                }
            
	            }
            
	        } else {
	            idINFO = instance_create_depth(obj_pj.x, obj_pj.y, 0, obj_INFO);
	            idINFO.padre = obj_pj.id;
	            idINFO.texto = "¡No podés usar la runa en movimiento!";
	        }
        
	    } else if (slots[i].tipo == "trabajo") {
		
			obj_skills_libres.mostrado = false;
	        if (slots[i].indice == 157 || slots[i].indice == 158 || slots[i].indice == 159) {
        
	            if (obj_panel_trabajos.mostrado) {
	                obj_panel_trabajos.mostrado = false;
	            } else {
            
	                switch (slots[i].indice) {
	                    case 157:
	                        obj_panel_trabajos.modo = 0;
	                        break;
	                    case 158:
	                        obj_panel_trabajos.modo = 1;
	                        break;
	                    case 159:
	                        obj_panel_trabajos.modo = 2;
	                        break;
	                }
                
	                obj_panel_trabajos.alarm[0] = 1;
                
	            }
            
            
	        }
		
	    }
    
	}
}
}