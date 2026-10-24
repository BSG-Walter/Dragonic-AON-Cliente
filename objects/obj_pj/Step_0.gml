if (!global.online_exportando) pj_actualizar_visuales();
if (online_activo()) { online_jugador_step(); exit; }
if (global.online_exportando) exit;
/// @description  Control general

/*

    Ultima tecla:
    vk_down = 0;
    vk_up = 1;
    vk_left = 2;a
    vk_right = 3;

*/
var bloqueo = false;

var _mouseDown = device_mouse_check_button(0, mb_left) || device_mouse_check_button(1, mb_left) || device_mouse_check_button(2, mb_left) || device_mouse_check_button(3, mb_left) || device_mouse_check_button(4, mb_left);
var _device = _mouseDown ? elegirDeviceLibre() : -1;
if (puedeMoverse) {
    if (rightKey) {
        direccion = 3;
    } else if (leftKey) {
        direccion = 2;
    } else if (upKey) {
        direccion = 1;
    } else if (downKey) {
        direccion = 0;
    }
}

if (pasos == 0 && puedeMoverse && !inmovilizado && !meditando) {    

    var sndPaso = -1;

    if (rightKey) {

        // Derecha
        
        if (!navega) {
            bloqueo = place_meeting(x + TILE_SIZE, y, obj_bloqueo_agua);
            sndPaso = snd_paso;
        } else {
            bloqueo = place_meeting(x + TILE_SIZE, y, obj_bloqueo_tierra);
            sndPaso = snd_barca;
        }
    
        if (
        !place_meeting(x + TILE_SIZE, y, obj_bloque_basic) && 
        !place_meeting(x + TILE_SIZE, y, obj_npc_basic) && 
        !bloqueo
        ) {
            xInicio = x;
            // frame = 0;
            alarm[0] = 1;
            x += spd;
            if (!muerto) {
                reproducirSonido(sndPaso, false, false);
            }
            pasos = 1;
            ultimaTecla = 3;     
        }        
        
    } else if (leftKey) {
    
        // Izquierda
    
        if (!navega) {
            bloqueo = place_meeting(x - TILE_SIZE, y, obj_bloqueo_agua);
            sndPaso = snd_paso;
        } else {
            bloqueo = place_meeting(x - TILE_SIZE, y, obj_bloqueo_tierra);
            sndPaso = snd_barca;
        }
    
        if (
        !place_meeting(x - TILE_SIZE, y, obj_bloque_basic) && 
        !place_meeting(x - TILE_SIZE, y, obj_npc_basic) && 
        !bloqueo
        ) {
            xInicio = x;
            // frame = 0;
            alarm[0] = 1;
            x -= spd;
            if (!muerto) {
                reproducirSonido(sndPaso, false, false);
            }
            pasos = 1;
            ultimaTecla = 2;
        }
    
    } else if (upKey) {
        
        // Arriba
        
        if (!navega) {
            bloqueo = place_meeting(x, y - TILE_SIZE, obj_bloqueo_agua);
            sndPaso = snd_paso;
        } else {
            bloqueo = place_meeting(x, y - TILE_SIZE, obj_bloqueo_tierra);
            sndPaso = snd_barca;
        }
    
        if (
        !place_meeting(x, y - TILE_SIZE, obj_bloque_basic) && 
        !place_meeting(x, y - TILE_SIZE, obj_npc_basic) && 
        !bloqueo
        ) {
            yInicio = y;
            // frame = 0;
            alarm[0] = 1;
            y -= spd;
            if (!muerto) {
                reproducirSonido(sndPaso, false, false);
            }
            pasos = 1;
            ultimaTecla = 1;  
        }
    
    } else if (downKey) {
        
        // Abajo
    
        if (!navega) {
            bloqueo = place_meeting(x, y + TILE_SIZE, obj_bloqueo_agua);
            sndPaso = snd_paso;
        } else {
            bloqueo = place_meeting(x, y + TILE_SIZE, obj_bloqueo_tierra);
            sndPaso = snd_barca;
        }
    
        if (
        !place_meeting(x, y + TILE_SIZE, obj_bloque_basic) && 
        !place_meeting(x, y + TILE_SIZE, obj_npc_basic) && 
        !bloqueo
        ) {
            yInicio = y;
            // frame = 0;
            alarm[0] = 1;
            y += spd;
            if (!muerto) {
                reproducirSonido(sndPaso, false, false);
            }
            pasos = 1;
            ultimaTecla = 0;
        }
    
    }
    
}

switch (ultimaTecla) {
    case 0:    
        if (pasos > 0) {
            if (pasos < pasosMax) {
                y += spd;
                pasos++;
                puedeMoverse = false;
            } else {
                y += spdUltimoPaso;
                y = floor(y);
                pasos = 0;
                puedeMoverse = true;     
            }
        }
        break;        
    case 1:
        if (pasos > 0) {
            if (pasos < pasosMax) {
                y -= spd;
                pasos++;
                puedeMoverse = false;
            } else {
                y -= spdUltimoPaso;
                y = floor(y);
                y++;
                pasos = 0;
                puedeMoverse = true;  
            } 
        }
        break;       
    case 2:    
        if (pasos > 0) {
            if (pasos < pasosMax) {
                x -= spd;
                pasos++;
                puedeMoverse = false;
            } else {
                x -= spdUltimoPaso;
                x = floor(x);
                x++;
                pasos = 0;
                puedeMoverse = true;
            }
        }
        break;        
    case 3:    
        if (pasos > 0) {
            if (pasos < pasosMax) {
                x += spd;
                pasos++;
                puedeMoverse = false;
            } else {
                x += spdUltimoPaso;
                x = floor(x);
                pasos = 0;
                puedeMoverse = true;      
            }
        }
        break;         
}

// puedeMoverse = false;

// Meditación

if (!meditando) {
    if (obj_tecla_f6.teclaApretada) {
    
        instance_create_depth(x, y, 0, obj_meditacion);
        meditando = true;
        
        if (instance_exists(obj_persona) && !obj_persona.muerto) {
            if (
            (obj_persona.x >= global.render_x&& (obj_persona.x <= global.render_x+ get_render_width())) &&
            (obj_persona.y >= global.render_y && (obj_persona.y <= global.render_y + get_render_height()))
            ) {
                xMeditando = x;
                yMeditando = y;
            } else {
                xMeditando = 0;
                yMeditando = 0;
            }
        } else {
            xMeditando = 0;
            yMeditando = 0;
        }        
        
        if (invisible) {
            with (obj_persona) {
                if (agitando) {
                    alarm[5] = 1;        
                }
            }
        }
        
    }
}

// Deja de trabajar

if (trabajando) { 

    var entra = false;

    if (trabajaMineria && trabajoActual != 154) {
        entra = true;
    }
    
    if (trabajaTala && trabajoActual != 147) {
        entra = true;
    }
    
    if (trabajaPesca && (trabajoActual != 155 && trabajoActual != 156)) {
        entra = true;
    }
    
    if (trabajaFragua && (obj_inventario.seleccionado != 148 && obj_inventario.seleccionado != 149 && obj_inventario.seleccionado != 150)) {
        entra = true;
    }

	var estaEnMovimiento = !puedeMoverse;

    if (estaEnMovimiento || entra) {
            
        trabajaMineria = false;
        trabajaTala = false;
        trabajaFragua = false;
        trabajaPesca = false;
        trabajando = false;
        indiceMineral = -1;
        var idINFO = instance_create_depth(x, y, 0, obj_INFO);
        idINFO.padre = id;
        idINFO.texto = "Dejaste de trabajar";
        alarm[11] = -1;
        
    }

}

if (!invisible) {
    xMeditando = 0;
    yMeditando = 0;
}

/* */
/// Control mouse

var device = -1;

if (
_mouseDown
) {

    device = _device;

    if (device != -1) {
    
        if (device_mouse_check_button_pressed(device, mb_left)) {
        
            obj_control_devices.devicesL[device] = true;
            
            // Ataque con arco / hechizo

            if (
            (device_mouse_x(device) >= global.render_x&& device_mouse_x(device) <= global.render_x+ get_render_width()) &&
            (device_mouse_y(device) >= global.render_y && device_mouse_y(device) <= global.render_y + get_render_height())
            ) {
                obj_hechizos.moviendoHechizo = false;
            }
            
            if (
            !atacaConArco && 
            !atacaConHechizo &&
            (device_mouse_x(device) >= global.render_x&& device_mouse_x(device) <= global.render_x+ 56) &&
            (device_mouse_y(device) >= global.render_y && device_mouse_y(device) <= global.render_y + TILE_SIZE)
            ) {
            
                if (obj_gui.panelActivo) {
                    obj_gui.panelActivo = false;
                } else {
                    obj_gui.panelActivo = true;
                }
                
            } else {
            
                if (!muerto) {
            
                    if (
                    atacaConArco && 
                    !meditando &&
                    (device_mouse_x(device) >= global.render_x&& device_mouse_x(device) <= global.render_x+ get_render_width()) &&
                    (device_mouse_y(device) >= global.render_y && device_mouse_y(device) <= global.render_y + get_render_height())
                    ) {
            
                        var idNPCAux = instance_position(device_mouse_x(device), device_mouse_y(device), obj_npc_basic);
                    
                        if (
                        (!position_meeting(device_mouse_x(device), device_mouse_y(device) , obj_area_flechas)) ||
                        (idNPCAux != noone && idNPCAux.hostil)
                        ) {
                            
                            // Arco
							ataqueArco(device_mouse_x(device), device_mouse_y(device));
                        }
                        
                    } else if (
                    puedeAtacar &&
                    atacaConHechizo && 
                    !meditando &&
                    (device_mouse_x(device) >= global.render_x&& device_mouse_x(device) <= global.render_x+ get_render_width()) &&
                    (device_mouse_y(device)  >= global.render_y && device_mouse_y(device)  <= global.render_y + get_render_height())
                    ) {
                    
                        // Hechizos
						lanzarHechizo(device_mouse_x(device), device_mouse_y(device));
                    } else {
                        
                        // Muestra la vida del NPC
                        
                        if (position_meeting(device_mouse_x(device), device_mouse_y(device) , obj_npc_basic)) {
                        
                            var idNPC = instance_position(device_mouse_x(device), device_mouse_y(device) , obj_npc_basic);
                            
                            var valido = true;
                            
                            if (instance_number(obj_persona) > 0) {
                                if (idNPC.object_index != obj_persona.object_index) {
                                    valido = true;
                                } else {
                                    valido = false;
                                }
                            }
                            
                            if (idNPC.hostil && valido) {
                            
                                var idINFO = instance_create_depth(idNPC.x, idNPC.y, 0, obj_INFO);
                                idINFO.padre = idNPC;
                                if (idNPC.domado) {
                                    idINFO.texto = "(Mascota) " + idNPC.nombre + " - " + string(idNPC.salud) + "/" + string(idNPC.saludMax);
                                } else if (idNPC.invocado) {
                                    idINFO.texto = "(Invocado) " + idNPC.nombre + " - " + string(idNPC.salud) + "/" + string(idNPC.saludMax);
                                } else {
                                    idINFO.texto = idNPC.nombre + " - " + string(idNPC.salud) + "/" + string(idNPC.saludMax);
                                }
                                idINFO.limite = 3;
                                idINFO.color = c_orange;
                            
                            }
                        
                        } else if (
                        (puedeMoverse) &&
                        (trabajoActual == 155 || trabajoActual == 156) &&
                        tile_layer_find(TILE_LAYER_GRASS, device_mouse_x(device), device_mouse_y(device) ) == -1
                        ) {
                        
                            // Hay agua... trabajo
                            
                            if (trabajoEquipado) {
                                if (trabajoEnInv != -1) {
                                
                                    var valido = false;
									
									if (navega) {
										if (distance_to_point(device_mouse_x(device), device_mouse_y(device)) <= TILE_SIZE)
											valido = true
									} else {
		                                if (position_meeting(device_mouse_x(device), device_mouse_y(device), obj_bloqueo_agua)) {
		                                    valido = true;
		                                }
			                            if (!valido)
			                                valido = hayAguaEn(x, y);
			                            if (!valido)
			                                valido = hayAguaEn(x - TILE_SIZE, y);
			                            if (!valido)
			                                valido = hayAguaEn(x - TILE_SIZE, y);
			                            if (!valido)
			                                valido = hayAguaEn(x, y - TILE_SIZE);
			                            if (!valido)
			                                valido = hayAguaEn(x - TILE_SIZE, y + TILE_SIZE);
									}
                                
                                    if (valido) {
                                    
                                        if (
                                        (device_mouse_x(device) <= x + TILE_SIZE && device_mouse_x(device) >= x - TILE_SIZE) &&
                                        (device_mouse_y(device)  <= y + TILE_SIZE && device_mouse_y(device)  >= y - TILE_SIZE)
                                        ) {
                                        
                                            posPescaX = x;
                                            posPescaY = y;
                                        
                                            activo = true;
                                            trabajaMineria = false;
                                            trabajaFragua = false;
                                            trabajaTala = false;
                                            trabajaPesca = true;
                                            trabajando = true;
                                            
											obj_skills_libres.mostrado = false;
											
                                            var idINFO = instance_create_depth(x, y, 0, obj_INFO);
                                            idINFO.texto = "Trabajando";
                                            idINFO.padre = id;
                                            
                                            if (trabajoActual == 155) {
                                                alarm[11] = 240;
                                            } else if (trabajoActual == 156) {
                                                alarm[11] = 180;
                                            }
                                            
                                        }
                                        
                                    }
                                }   
                            }
                            
                        } else {
                            if (position_meeting(device_mouse_x(device), device_mouse_y(device) , obj_item)) {
                                var idItem = instance_position(device_mouse_x(device), device_mouse_y(device) , obj_item);
                                var idINFO = instance_create_depth(idItem.x, idItem.y, 0, obj_INFO);
                                idINFO.texto = nombreItem(idItem.indice) + " (" + string(idItem.cantidad) + ")";
                                idINFO.padre = idItem;
                            } else if (position_meeting(device_mouse_x(device), device_mouse_y(device) , obj_oro)) {
                                var idOro = instance_position(device_mouse_x(device), device_mouse_y(device) , obj_oro);
                                var idINFO = instance_create_depth(idOro.x, idOro.y, 0, obj_INFO);
                                idINFO.texto = "Monedas de oro (" + string(idOro.valor) + ")";
                                idINFO.padre = idOro;
                            }
                        }
                        
                    }
                
                }
            
            }
            
            
            obj_control_devices.devicesL[device] = false;
            
        }
        
    }

}

/* */
/*  */