if (online_activo()) { if (visible && !obj_online.menu_open && !instance_exists(obj_pausa)) online_inventario_step(); exit; }
/// @description  Control general / Control mouse

if (!visible) {
    tirando = false;
}

var device = -1;

if (
device_mouse_check_button(0, mb_left) ||
device_mouse_check_button(1, mb_left) ||
device_mouse_check_button(2, mb_left) ||
device_mouse_check_button(3, mb_left) ||
device_mouse_check_button(4, mb_left)
) {

    device = elegirDeviceLibre();

    if (device != -1) {
    
        if (device_mouse_check_button_pressed(device, mb_left)) {
            
            if (!dobleClic) {
            
                // /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                // Seleccionar item
                // /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
                if (visible && !obj_pj.muerto) {
                
                    if (!obj_tecla_T.teclaApretada) {
                    
                        var posX = 0;
                        var posY = 0;
                            
                        if (
                        device_mouse_x(device) >= global.inventario_x + 121 &&
                        device_mouse_x(device) <= global.inventario_x + INVENTARIO_WIDTH + 320 &&
                        device_mouse_y(device) >= global.inventario_y + 8 &&
                        device_mouse_y(device) <= global.inventario_y + 7 + 64
                        ) {
                        
                            obj_control_devices.devicesL[device] = true;
                        
                            obj_hechizos.moviendoHechizo = false;
                              
                            // Doble clic
                            
                            dobleClic = true;
                            if (alarm[6] == -1) {
                                alarm[6] = 15;
                            }
                        
                            var posX = device_mouse_x(device);
                            var posY = device_mouse_y(device);
                            
                            posX = posX - global.inventario_x - INVENTARIO_WIDTH;
                            posY = posY - global.inventario_y - 7;
                            
                            var posItem = 0;
                            
                            if (posY <= 32) {
                            
                                // Arriba
                                
                                var i = 0;
                                
                                repeat (10) {
                                    if (posX >= 32 * (i) && posX < (i + 1) * 32) {
                                        posItem = i;
                                        break;
                                    }
                                    
                                    i++;
                                }
                                
                            } else {
                            
                                // Abajo
                                
                                var i = 0;
                                
                                repeat (10) {
                                    if (posX >= 32 * (i) && posX < (i + 1) * 32) {
                                        posItem = i + 10;
                                        break;
                                    }
                                    
                                    i++;
                                }
                                
                            }
                            
                            // TRABAJO CON EL ITEM
                            
							if (obj_mover_inventario.moviendoItem && seleccionado != -1) {
							
								dobleClic = false;
                                
								if (slots[posItem].indice == -1) {
									
									slots[posItem] = crearSlotInv(seleccionado, slots[posSeleccionado].cant, false);
									slots[posSeleccionado] = crearSlotInv(-1, 0, false);
									
								} else {

									var _aux = slots[posItem];
									slots[posItem] = slots[posSeleccionado];
									slots[posSeleccionado] = _aux;
									
								}
								//actualizamos el valor de la flecha actual seleccionada
								if (slots[posSeleccionado].tipo == "flecha") obj_pj.flechaEnInv = posSeleccionado
								if (slots[posItem].tipo == "flecha") obj_pj.flechaEnInv = posItem
								
                                seleccionado = slots[posItem].indice;
                                posSeleccionado = posItem;
                                posDobleClic = posItem;
								obj_mover_inventario.moviendoItem = false;
							
							} else if (slots[posItem].indice != -1) {
                                
                                var antesSeleccionado = seleccionado;
                                var posAntesSeleccionado = posSeleccionado;
                                
                                seleccionado = slots[posItem].indice;
                                posSeleccionado = posItem;
                                posDobleClic = posItem;
                                alarm[2] = 15;
                                
                                var validoRaza = false;
                                var validoGenero = false;
                                var validoSkill = false;
                                var validoClase = false;
                                
                                // Raza
                                
                                if (
                                slots[posItem].raza == -1 ||
                                slots[posItem].raza == obj_pj.nroRaza
                                ) {
                                    validoRaza = true;
                                } else {
                                    switch (slots[posItem].raza) {
                                        case 5:
                                            if (obj_pj.nroRaza == 0 || obj_pj.nroRaza == 1 || obj_pj.nroRaza == 2) {
                                                validoRaza = true;
                                            }
                                            break;
                                        case 6:
                                            if (obj_pj.nroRaza == 3 || obj_pj.nroRaza == 4) {
                                                validoRaza = true;
                                            }
                                            break;
                                        case 7:
                                            if (obj_pj.nroRaza == 0 || obj_pj.nroRaza == 1) {
                                                validoRaza = true;
                                            }
                                            break;
                                        case 8:
                                            if (obj_pj.nroRaza == 1 || obj_pj.nroRaza == 2) {
                                                validoRaza = true;
                                            }
                                            break;
                                        case 9:
                                            if (obj_pj.nroRaza == 0 || obj_pj.nroRaza == 3 || obj_pj.nroRaza == 4) {
                                                validoRaza = true;
                                            }
                                            break;
                                        case 10:
                                            if (obj_pj.nroRaza != 2) {
                                                validoRaza = true;
                                            }
                                            break;
                                    }
                                }
                                
                                // Género
                                
                                if (
                                slots[posItem].genero == -1 ||
                                slots[posItem].genero == obj_pj.genero
                                ) {
                                    validoGenero = true;
                                }
                                
                                // Clase
                                
                                switch (obj_pj.clase) {
                                    case 0:
                                        if (slots[posItem].clases[0]) {
                                            validoClase = true;
                                        }
                                        break;
                                    case 1:
                                        if (slots[posItem].clases[1]) {
                                            validoClase = true;
                                        }
                                        break;
                                    case 2:
                                        if (slots[posItem].clases[2]) {
                                            validoClase = true;
                                        }
                                        break;
                                    case 3:
                                        if (slots[posItem].clases[3]) {
                                            validoClase = true;
                                        }
                                        break;
                                    case 4:
                                        if (slots[posItem].clases[4]) {
                                            validoClase = true;
                                        }
                                        break;
                                    case 5:
                                        if (slots[posItem].clases[5]) {
                                            validoClase = true;
                                        }
                                        break;
                                    case 6:
                                        if (slots[posItem].clases[6]) {
                                            validoClase = true;
                                        }
                                        break;
                                    case 7:
                                        if (slots[posItem].clases[7]) {
                                            validoClase = true;
                                        }
                                        break;
                                    case 8:
                                        if (slots[posItem].clases[8]) {
                                            validoClase = true;
                                        }
                                        break;
                                }
                                
                                // Skills
                                
                                if (obj_pj.skills[slots[posItem].nroSkill] >= slots[posItem].skillReq) {
                                    validoSkill = true;
                                }
                                
                                if (!validoRaza) {
                                    var idINFO = instance_create_depth(obj_pj.x, obj_pj.y, 0, obj_INFO);
                                    idINFO.padre = obj_pj.id;
                                    idINFO.texto = "¡Tu raza no puede usar este ítem!"; 
                                } else if (!validoGenero) {
                                    var idINFO = instance_create_depth(obj_pj.x, obj_pj.y, 0, obj_INFO);
                                    idINFO.padre = obj_pj.id;
                                    idINFO.texto = "¡Tu género no puede usar este ítem!"; 
                                } else if (!validoClase) {
                                    var idINFO = instance_create_depth(obj_pj.x, obj_pj.y, 0, obj_INFO);
                                    idINFO.padre = obj_pj.id;
                                    idINFO.texto = "¡Tu clase no puede usar este ítem!"; 
                                } else if (!validoSkill) {
                                    idFaltaSkill = crearTextoFaltaSkill(slots[posItem].nroSkill, slots[posItem].skillReq);
                                }                
                                
                                if (validoRaza && validoGenero && validoSkill && validoClase) {
									
									obj_skills_libres.mostrado = false;
                                
                                    if (slots[posItem].cant >= 1) {
                                        if (slots[posItem].tipo == "arma") {
                                            if (obj_pj.armaEnInv != posItem) {
                                            
                                                obj_pj.armaActual = slots[posItem].indice;
                                                obj_pj.sprArma = obtenerSpriteArma(obj_pj.armaActual);
                                                obj_pj.armaEnInv = posItem;

                                                var i = 0;

                                                repeat (maximoInv) {
                                                    if (slots[i].tipo == "arma") {
                                                        slots[i].equipado = false;
                                                    }
                                                    i++;
                                                }

                                                slots[posItem].equipado = true;
                                                reproducirSonido(snd_equiparODesequiparArma, false, false);

                                            } else {
                                                if (slots[posItem].indice < 21 || slots[posItem].indice > 27) {
                                                    obj_pj.armaActual = -1;
                                                    obj_pj.sprArma = -1;
                                                    obj_pj.armaEnInv = -1;
                                                    slots[posItem].equipado = false;
                                                    reproducirSonido(snd_equiparODesequiparArma, false, false);
                                                } else {
                                                    if (antesSeleccionado == slots[posItem].indice && posAntesSeleccionado == posItem) {
                                                        obj_pj.armaActual = -1;
                                                        obj_pj.sprArma = -1;
                                                        obj_pj.armaEnInv = -1;
                                                        slots[posItem].equipado = false;
                                                        reproducirSonido(snd_equiparODesequiparArma, false, false);
                                                    }
                                                }
                                            }
                                        } else if (slots[posItem].tipo == "flecha") {
                                            if (obj_pj.flechaEnInv != posItem) {
                                            
                                                obj_pj.flechaActual = slots[posItem].indice;
                                                obj_pj.flechaEnInv = posItem;
                                                
                                                var i = 0;
                                                
                                                repeat (maximoInv) {
                                                    if (slots[i].tipo == "flecha") {
                                                        slots[i].equipado = false;
                                                    }
                                                    i++;
                                                }
                                                
                                                slots[posItem].equipado = true;
                                                
                                            } else {
                                                obj_pj.flechaActual = -1;
                                                obj_pj.flechaEnInv = -1;
                                                slots[posItem].equipado = false;
                                            }
                                        } else if (slots[posItem].tipo == "ropa") {
                                            if (obj_pj.ropaEnInv != posItem) {
                                            
                                                obj_pj.desnudo = false;
                                                obj_pj.ropaActual = slots[posItem].indice;
                                                obj_pj.ropaEnInv = posItem;
                                                
                                                var i = 0;
                                                
                                                repeat (maximoInv) {
                                                    if (slots[i].tipo == "ropa") {
                                                        slots[i].equipado = false;
                                                    }
                                                    i++;
                                                }
                                                
                                                slots[posItem].equipado = true;
                                                obj_pj.ropaIndexada = false;
                                                
                                            } else {
                                                obj_pj.desnudo = true;
                                                obj_pj.ropaActual = -1;
                                                obj_pj.ropaEnInv = -1;
                                                slots[posItem].equipado = false;
                                            }
                                        } else if (slots[posItem].tipo == "escudo") {
                                            if (obj_pj.escudoEnInv != posItem) {

                                                obj_pj.escudoActual = slots[posItem].indice;
                                                obj_pj.sprEscudo = obtenerSpriteEscudo(obj_pj.escudoActual);
                                                obj_pj.escudoEnInv = posItem;

                                                var i = 0;

                                                repeat (maximoInv) {
                                                    if (slots[i].tipo == "escudo") {
                                                        slots[i].equipado = false;
                                                    }
                                                    i++;
                                                }

                                                slots[posItem].equipado = true;

                                            } else {
                                                obj_pj.escudoActual = -1;
                                                obj_pj.sprEscudo = -1;
                                                obj_pj.escudoEnInv = -1;
                                                slots[posItem].equipado = false;
                                            }
                                        } else if (slots[posItem].tipo == "casco") {
                                            if (obj_pj.cascoEnInv != posItem) {
                                            
                                                obj_pj.cascoActual = slots[posItem].indice;
                                                obj_pj.cascoEnInv = posItem;
                                                
                                                var i = 0;
                                                
                                                repeat (maximoInv) {
                                                    if (slots[i].tipo == "casco") {
                                                        slots[i].equipado = false;
                                                    }
                                                    i++;
                                                }
                                                
                                                slots[posItem].equipado = true;
                                                
                                            } else {
                                                obj_pj.cascoActual = -1;
                                                obj_pj.cascoEnInv = -1;
                                                slots[posItem].equipado = false;
                                            }
                                        } else if (slots[posItem].tipo == "laud") {
                                            if (obj_pj.laudEnInv != posItem) {
                                            
                                                obj_pj.laudActual = slots[posItem].indice;
                                                obj_pj.laudEnInv = posItem;
                                                
                                                var i = 0;
                                                
                                                repeat (maximoInv) {
                                                    if (slots[i].tipo == "laud") {
                                                        slots[i].equipado = false;
                                                    }
                                                    i++;
                                                }
                                                
                                                obj_pj.laudEquipado = true;
                                                slots[posItem].equipado = true;
                                                
                                            } else {
                                                obj_pj.laudEquipado = false;
                                                obj_pj.laudActual = -1;
                                                obj_pj.laudEnInv = -1;
                                                slots[posItem].equipado = false;
                                            }
                                        } else if (slots[posItem].tipo == "trabajo") {
                                            if (obj_pj.trabajoEnInv != posItem) {
                                            
                                                obj_pj.trabajoActual = slots[posItem].indice;
                                                obj_pj.trabajoEnInv = posItem;
                                                
                                                var i = 0;
                                                
                                                repeat (maximoInv) {
                                                    if (slots[i].tipo == "trabajo") {
                                                        slots[i].equipado = false;
                                                    }
                                                    i++;
                                                }
                                                
                                                obj_pj.trabajoEquipado = true;
                                                slots[posItem].equipado = true;
                                                
                                            } else {
                                                obj_pj.trabajoEquipado = false;
                                                obj_pj.trabajoActual = -1;
                                                obj_pj.trabajoEnInv = -1;
                                                slots[posItem].equipado = false;
                                            }
                                        }
                                    } else {
                                        seleccionado = -1;
                                    }
                                    
                                } else {
                                    // seleccionado = -1;
                                }
                                
                            }
                         
                            obj_control_devices.devicesL[device] = false;
                               
                        }
                    
                    } else {
                        alarm[0] = 1;
                    }
                
                } else if (visible && obj_pj.muerto) {
                    
                    if (!obj_tecla_T.teclaApretada) {
                    
                        var posX = 0;
                        var posY = 0;
                            
                        if (
                        device_mouse_x(device) >= global.inventario_x + 121 &&
                        device_mouse_x(device) <= global.inventario_x + INVENTARIO_WIDTH + 320 &&
                        device_mouse_y(device) >= global.inventario_y + 8 &&
                        device_mouse_y(device) <= global.inventario_y + 7 + 64
                        ) {
                        
                            obj_control_devices.devicesL[device] = true;
                
                            obj_hechizos.moviendoHechizo = false;
                        
                            var posX = device_mouse_x(device);
                            var posY = device_mouse_y(device);
                            
                            posX = posX - global.inventario_x - INVENTARIO_WIDTH;
                            posY = posY - global.inventario_y - 7;
                            
                            var posItem = 0;
                            
                            if (posY <= 32) {
                            
                                // Arriba
                                
                                var i = 0;
                                
                                repeat (10) {
                                    if (posX >= 32 * (i) && posX < (i + 1) * 32) {
                                        posItem = i;
                                        break;
                                    }
                                    
                                    i++;
                                }
                                
                            } else {
                            
                                // Abajo
                                
                                var i = 0;
                                
                                repeat (10) {
                                    if (posX >= 32 * (i) && posX < (i + 1) * 32) {
                                        posItem = i + 10;
                                        break;
                                    }
                                    
                                    i++;
                                }
                                
                            }
                            
                            // TRABAJO CON EL ITEM
                
                            if (slots[posItem].indice != -1) {
                                if (slots[posItem].tipo == "barca" || slots[posItem].tipo == "runa") {
									obj_skills_libres.mostrado = false;
                                    seleccionado = slots[posItem].indice;
                                    posSeleccionado = posItem;
                                } else {
                                    seleccionado = -1;
                                    posSeleccionado = -1;
                                }
                            } else {
                                seleccionado = -1;
                                posSeleccionado = -1;
                            }
                            
                            obj_control_devices.devicesL[device] = false;
                            
                        }            
                            
                    }
                                        
                } 
            
            } else {
            
                // /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                // Tirar item de a 1
                // /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

                alarm[6] = -1;
                dobleClic = false;
                              
                tileInvalido = false;
                  
                with (obj_pj) {
                    if (place_meeting(x, y, obj_tile_invalido)) {
                        other.tileInvalido = true;
                    }
                }
                
                if (visible && !obj_pj.muerto && (!tileInvalido || obj_pj.navega)) {
                
                    if (!obj_tecla_T.teclaApretada) {
                    
                        var posX = 0;
                        var posY = 0;
                            
                        if (
                        device_mouse_x(device) >= global.inventario_x + 121 &&
                        device_mouse_x(device) <= global.inventario_x + INVENTARIO_WIDTH + 320 &&
                        device_mouse_y(device) >= global.inventario_y + 8 &&
                        device_mouse_y(device) <= global.inventario_y + 7 + 64
                        ) {
                        
                            obj_control_devices.devicesL[device] = true;
                
                            obj_hechizos.moviendoHechizo = false;
                        
                            var posX = device_mouse_x(device);
                            var posY = device_mouse_y(device);
                            
                            posX = posX - global.inventario_x - INVENTARIO_WIDTH;
                            posY = posY - global.inventario_y - 7;
                            
                            var posItem = 0;
                            
                            if (posY <= 32) {
                            
                                // Arriba
                                
                                var i = 0;
                                
                                repeat (10) {
                                    if (posX >= 32 * (i) && posX < (i + 1) * 32) {
                                        posItem = i;
                                        break;
                                    }
                                    
                                    i++;
                                }
                                
                            } else {
                            
                                // Abajo
                                
                                var i = 0;
                                
                                repeat (10) {
                                    if (posX >= 32 * (i) && posX < (i + 1) * 32) {
                                        posItem = i + 10;
                                        break;
                                    }
                                    
                                    i++;
                                }
                                
                            }
                            
                            // TRABAJO CON EL ITEM
                            
                            if (slots[posItem].indice != -1) {
                            
                                if (posItem == posDobleClic) {
                                                    
                                    deviceDC = device;
                                    alarm[5] = SECOND;
                                
                                    seleccionado = slots[posItem].indice;
                                    posSeleccionado = posItem;
                                    
                                    if (slots[posItem].cant >= 1) {
                                        if (obj_pj.puedeMoverse && !obj_flecha_abajo.apretada && !obj_flecha_arriba.apretada && !obj_flecha_izq.apretada && !obj_flecha_der.apretada) {
                                        
                                            valido = true;
                                            
                                            if (!tiraDeA1) {
                                                tiraDeA1 = true;
                                            }
                                            
                                            alarm[1] = SECOND * 2;
                                        
                                            if (
                                            !position_meeting(obj_pj.x, obj_pj.y - 16, obj_item) &&
                                            !position_meeting(obj_pj.x, obj_pj.y - 16, obj_oro)
                                            ) {
                                                var idItemTirado = instance_create_depth(obj_pj.x, obj_pj.y, 0, obj_item);
                                                idItemTirado.superpone = true;
                                                idItemTirado.indice = slots[posItem].indice;
                                                idItemTirado.cantidad = 1;
                                                idItemTirado.tipo = slots[posItem].tipo;
                                            } else if (position_meeting(obj_pj.x, obj_pj.y - 16, obj_item)) {
                                                var idItemTirado = instance_position(obj_pj.x, obj_pj.y - 16, obj_item);
                                                if (idItemTirado.indice == slots[posItem].indice && idItemTirado.cantidad < 10000) {
                                                    idItemTirado.cantidad++;
                                                } else {
                                                    valido = false;
                                                }
                                            }
                                            
                                            if (valido) {
                                                if (slots[posItem].cant > 1) {
                                                    slots[posItem].cant--;
                                                } else {
                                                
                                                    if (slots[posItem].indice == seleccionado) {
                                                        seleccionado = -1;
                                                    }
                                                    
                                                    if (posItem == posSeleccionado) {
                                                        posSeleccionado = -1;
                                                    }
                                                    
                                                    if (slots[posItem].tipo == "ropa" && posItem == obj_pj.ropaEnInv) {
                                                        obj_pj.desnudo = true;
                                                        obj_pj.ropaActual = -1;
                                                        obj_pj.ropaEnInv = -1;
                                                        obj_pj.ropaIndexada = false;
                                                    } else if (slots[posItem].tipo == "arma" && posItem == obj_pj.armaEnInv) {
                                                        obj_pj.armaActual = -1;
                                                        obj_pj.armaEnInv = -1;
                                                        obj_pj.sprArma = -1;
                                                        reproducirSonido(snd_equiparODesequiparArma, false, false);
                                                    } else if (slots[posItem].tipo == "flecha" && posItem == obj_pj.flechaEnInv) {
                                                        obj_pj.flechaActual = -1;
                                                        obj_pj.flechaEnInv = -1;
                                                    } else if (slots[posItem].tipo == "casco" && posItem == obj_pj.cascoEnInv) {
                                                        obj_pj.cascoActual = -1;
                                                        obj_pj.cascoEnInv = -1;
                                                    } else if (slots[posItem].tipo == "escudo" && posItem == obj_pj.escudoEnInv) {
                                                        obj_pj.escudoActual = -1;
                                                        obj_pj.escudoEnInv = -1;
                                                        obj_pj.sprEscudo = -1;
                                                    } else if (slots[posItem].tipo == "laud" && posItem == obj_pj.laudEnInv) {
                                                        obj_pj.laudActual = -1;
                                                        obj_pj.laudEnInv = -1;
                                                        obj_pj.laudEquipado = false;
                                                    } else if (slots[posItem].tipo == "trabajo" && posItem == obj_pj.trabajoEnInv) {
                                                        obj_pj.trabajoActual = -1;
                                                        obj_pj.trabajoEnInv = -1;
                                                        obj_pj.trabajoEquipado = false;
                                                        obj_panel_trabajos.mostrado = false;
                                                    }
                                                
                                                    slots[posItem].cant = 0;
                                                    slots[posItem].indice = -1;
                                                    slots[posItem].tipo = "";
                                                    slots[posItem].equipado = false;
                                                    slots[posItem].nombre = "Vacío";
                                                    
                                                }
                                            }
                                            
                                        }
                                    }
                                }
                            
                            }
                            
                            obj_control_devices.devicesL[device] = false;
                            
                        }
                    
                    } else {
                        alarm[0] = 1;
                    }
                
                }
            
            }
            
        }      
        
    }

}

