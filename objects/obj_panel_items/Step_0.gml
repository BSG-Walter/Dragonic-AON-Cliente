if (online_activo() && mostrado) {
    var _comerciante = modoBanco ? idBanquero : idPadre;
    if (!instance_exists(obj_pj) || !instance_exists(_comerciante)) {
        mostrado = false;
    } else if (obj_pj.muerto || point_distance(obj_pj.x, obj_pj.y,
        _comerciante.x, _comerciante.y) > ONLINE_MERCHANT_MAX_DISTANCE) {
        mostrado = false;
    }
}
if (online_activo() && instance_exists(obj_pausa)) exit;
/// @description  Control general / control mouse

if (!modoBanco) {
    if (idPadre != -1) {
        if (instance_exists(idPadre)) {
            if (
            (idPadre.x < global.render_x || idPadre.x > global.render_x + get_render_width()) ||
            (idPadre.y < global.render_y || idPadre.y > global.render_y + get_render_height())
            ) {
               mostrado = false; 
            }
        } else {
            mostrado = false;  
        }
    }
} else {
    if (idBanquero != -1) {
        if (instance_exists(idBanquero)) {
            if (
            (idBanquero.x < global.render_x || idBanquero.x > global.render_x + get_render_width()) ||
            (idBanquero.y < global.render_y || idBanquero.y > global.render_y + get_render_height())
            ) {
               mostrado = false; 
            }
        } else {
            mostrado = false;  
        }
    }
}


if (mostrado) {
    x = global.render_x + get_render_width() * 0.5;
    y = global.render_y + get_render_height() * 0.5;    
} else {
    idPadre = -1;
    idBanquero = -1;
    indiceItem = -1;
    descItem = "";
    precioItem = 0;
    validoItem = "";     
    modoBanco = false;
    deviceMantenido = -1;
    clicMantenido = false;
    alarm[0] = -1;
    alarm[1] = -1;
}

// Control mouse

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
    
        if (device_mouse_check_button_pressed(device, mb_left) && position_meeting(device_mouse_x(device), device_mouse_y(device), self)) {
        
            obj_control_devices.devicesL[device] = true;
            
            // Clic

            // //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            // MODO COMÚN
            // //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            
            if (mostrado && !modoBanco) {
            
                obj_hechizos.moviendoHechizo = false;
                
                var posX = global.render_x + get_render_width() * 0.5 - 144;
                var posY = global.render_y + get_render_height() * 0.5 - 113;
                
                if (
                (device_mouse_x(device) >= posX + 150 && device_mouse_x(device) <= posX + 279) &&
                (device_mouse_y(device) >= posY + 47 && device_mouse_y(device) <= posY + 207)
                ) {
                
                    var modY = posY + 47;
                
                    sectorNpc = false;
                    sectorPj = true;
                    
                    var _my = device_mouse_y(device) - modY;
                    if (_my >= 0 && _my < 160) indiceItem = floor(_my / 8); else indiceItem = -1;
                    
                    if (indiceItem != -1) {
                        if (obj_inventario.slots[indiceItem].indice != -1) {
                        
                            var datosItem = descripcionItem(obj_inventario.slots[indiceItem].indice);
                            descItem = datosItem.desc;
                            precioItem = datosItem.precio;
                            
                            datosItem = configurarItem(obj_inventario.slots[indiceItem].indice);
                            
                            var validoRaza = false;
                            var validoGenero = false;
                            var validoSkill = false;
                            var validoClase = false;
                            
                            // Raza
                            
                            if (
                            datosItem.raza == -1 ||
                            datosItem.raza == obj_pj.nroRaza
                            ) {
                                validoRaza = true;
                            } else {
                                switch (datosItem.raza) {
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
                            datosItem.genero == -1 ||
                            datosItem.genero == obj_pj.genero
                            ) {
                                validoGenero = true;
                            }
                            
                            // Clase
                            
                            switch (obj_pj.clase) {
                                case 0:
                                    if (datosItem.clases[0]) {
                                        validoClase = true;
                                    }
                                    break;
                                case 1:
                                    if (datosItem.clases[1]) {
                                        validoClase = true;
                                    }
                                    break;
                                case 2:
                                    if (datosItem.clases[2]) {
                                        validoClase = true;
                                    }
                                    break;
                                case 3:
                                    if (datosItem.clases[3]) {
                                        validoClase = true;
                                    }
                                    break;
                                case 4:
                                    if (datosItem.clases[4]) {
                                        validoClase = true;
                                    }
                                    break;
                                case 5:
                                    if (datosItem.clases[5]) {
                                        validoClase = true;
                                    }
                                    break;
                                case 6:
                                    if (datosItem.clases[6]) {
                                        validoClase = true;
                                    }
                                    break;
                                case 7:
                                    if (datosItem.clases[7]) {
                                        validoClase = true;
                                    }
                                    break;
                                case 8:
                                    if (datosItem.clases[8]) {
                                        validoClase = true;
                                    }
                                    break;
                            }
                            
                            // Skills
                            
                            if (obj_pj.skills[datosItem.nroSkill] >= datosItem.skillReq) {
                                validoSkill = true;
                            }
                            
                            // Valido todo
                            
                            if (validoSkill && validoClase && validoGenero && validoRaza) {
                            
                                if (obj_inventario.slots[indiceItem].indice == 144) {
                                    validoItem = "Podés usar este ítem (Ver manual para mas info.)";
                                } else if (obj_inventario.slots[indiceItem].indice >= SPELL_INDEX_BASE && obj_inventario.slots[indiceItem].indice <= SPELL_INDEX_BASE + 19) {
                                    validoItem = "Podés aprender este hechizo (Ver manual para mas info.)";
                                } else {
                                    validoItem = "Podés usar este ítem";
                                }
                                    
                            } else {
                                if (!validoRaza) {
                                    validoItem = "Tu raza no puede usar este ítem";
                                } else if (!validoGenero) {
                                    validoItem = "Tu género no puede usar este ítem";
                                } else if (!validoClase) {
                                    validoItem = "Tu clase no puede usar este ítem";
                                } else if (!validoSkill) {
                                    validoItem = "No tienes suficientes skillpoints para usar este ítem";
                                }
                            }
                            
                        }
                    }
                    
                } else if (
                (device_mouse_x(device) >= posX + 8 && device_mouse_x(device) <= posX + 137) &&
                (device_mouse_y(device) >= posY + 47 && device_mouse_y(device) <= posY + 207)
                ) {
                
                    var modY = posY + 47;
                
                    sectorNpc = true;
                    sectorPj = false;
                    
                    var _my = device_mouse_y(device) - modY;
                    if (_my >= 0 && _my < 160) indiceItem = floor(_my / 8); else indiceItem = -1;
                    
                    if (indiceItem != -1) {
                        if (instance_exists(idPadre)) {
                            if (idPadre.slots[indiceItem].indice != -1) {
                            
                                var datosItem = descripcionItem(idPadre.slots[indiceItem].indice);
                                descItem = datosItem.desc;
                                        
                                var modPrecio = 1;
                                
                                if (obj_pj.skills[16] >= 0 && obj_pj.skills[16] <= 10) {
                                    modPrecio = 1;
                                } else if (obj_pj.skills[16] >= 11 && obj_pj.skills[16] <= 20) {
                                    modPrecio = 1.15;
                                }  else if (obj_pj.skills[16] >= 21 && obj_pj.skills[16] <= 30) {
                                    modPrecio = 1.25;
                                }  else if (obj_pj.skills[16] >= 31 && obj_pj.skills[16] <= 40) {
                                    modPrecio = 1.35;
                                }  else if (obj_pj.skills[16] >= 41 && obj_pj.skills[16] <= 50) {
                                    modPrecio = 1.45;
                                }  else if (obj_pj.skills[16] >= 51 && obj_pj.skills[16] <= 60) {
                                    modPrecio = 1.5;
                                }  else if (obj_pj.skills[16] >= 61 && obj_pj.skills[16] <= 70) {
                                    modPrecio = 1.65;
                                }  else if (obj_pj.skills[16] >= 71 && obj_pj.skills[16] <= 80) {
                                    modPrecio = 1.75;
                                }  else if (obj_pj.skills[16] >= 81 && obj_pj.skills[16] <= 90) {
                                    modPrecio = 1.85;
                                }  else if (obj_pj.skills[16] >= 91 && obj_pj.skills[16] <= 99) {
                                    modPrecio = 1.95;
                                } else {
                                    modPrecio = 2;
                                }
                                
                                precioItem = floor((datosItem.precio * 2) / modPrecio);
                                
                                if (precioItem <= 0) {
                                    precioItem = 1;
                                }
                                              
                                datosItem = configurarItem(idPadre.slots[indiceItem].indice);
                                
                                var validoRaza = false;
                                var validoGenero = false;
                                var validoSkill = false;
                                var validoClase = false;
                                
                                // Raza
                                
                                if (
                                datosItem.raza == -1 ||
                                datosItem.raza == obj_pj.nroRaza
                                ) {
                                    validoRaza = true;
                                } else {
                                    switch (datosItem.raza) {
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
                                datosItem.genero == -1 ||
                                datosItem.genero == obj_pj.genero
                                ) {
                                    validoGenero = true;
                                }
                                
                                // Clase
                                
                                switch (obj_pj.clase) {
                                    case 0:
                                        if (datosItem.clases[0]) {
                                            validoClase = true;
                                        }
                                        break;
                                    case 1:
                                        if (datosItem.clases[1]) {
                                            validoClase = true;
                                        }
                                        break;
                                    case 2:
                                        if (datosItem.clases[2]) {
                                            validoClase = true;
                                        }
                                        break;
                                    case 3:
                                        if (datosItem.clases[3]) {
                                            validoClase = true;
                                        }
                                        break;
                                    case 4:
                                        if (datosItem.clases[4]) {
                                            validoClase = true;
                                        }
                                        break;
                                    case 5:
                                        if (datosItem.clases[5]) {
                                            validoClase = true;
                                        }
                                        break;
                                    case 6:
                                        if (datosItem.clases[6]) {
                                            validoClase = true;
                                        }
                                        break;
                                    case 7:
                                        if (datosItem.clases[7]) {
                                            validoClase = true;
                                        }
                                        break;
                                    case 8:
                                        if (datosItem.clases[8]) {
                                            validoClase = true;
                                        }
                                        break;
                                }
                                
                                // Skills
                                
                                if (obj_pj.skills[datosItem.nroSkill] >= datosItem.skillReq) {
                                    validoSkill = true;
                                }
                                
                                // Valido todo
                            
                                if (validoSkill && validoClase && validoGenero && validoRaza) {
                                
                                    if (idPadre.slots[indiceItem].indice == 144) {
                                        validoItem = "Podés usar este ítem (Ver manual para mas info.)";
                                    } else if (idPadre.slots[indiceItem].indice >= SPELL_INDEX_BASE && idPadre.slots[indiceItem].indice <= SPELL_INDEX_BASE + 19) {
                                        validoItem = "Podés aprender este hechizo (Ver manual para mas info.)";
                                    } else {
                                        validoItem = "Podés usar este ítem";
                                    }
                                
                                     
                                } else {
                                    if (!validoRaza) {
                                        validoItem = "Tu raza no puede usar este ítem";
                                    } else if (!validoGenero) {
                                        validoItem = "Tu género no puede usar este ítem";
                                    } else if (!validoClase) {
                                        validoItem = "Tu clase no puede usar este ítem";
                                    } else if (!validoSkill) {
                                        validoItem = "No tienes suficientes skillpoints para usar este ítem";
                                    }
                                }
                                
                            }
                        }
                    }
                    
                } else if (device_mouse_x(device) >= posX + 272 && device_mouse_y(device) <= posY + 15) {
                    mostrado = false;   
                    image_index = 0;
                    campoCantidadS = "1";
                } else if (
                (device_mouse_x(device) >= posX + 122 && device_mouse_x(device) <= posX + 167) &&
                (device_mouse_y(device) >= posY + 210 && device_mouse_y(device) <= posY + 223)
                ) {
                
                    // Abro o cierro el numpad
                     
                    if (image_index == 0) {
                        image_index = 1;
                    } else {
                        image_index = 0;
                    }                  
                    
                    campoCantidadS = "0";  
                    
                } else if (                
                (device_mouse_x(device) >= posX + 288 && device_mouse_x(device) <= posX + 336) &&
                (device_mouse_y(device) >= posY + 74 && device_mouse_y(device) <= posY + 134)
                ) {
                
                    // Escribo con el numpad
                     
                    if (image_index == 1) {
                        
                        var indiceNPX = -1;
                        var indiceNPY = -1;
                    
                        if ((device_mouse_x(device) >= posX + 288 && device_mouse_x(device) < posX + 304)) {
                            // Puede ser el 1, el 4 o el 7
                            indiceNPX = 0;
                        } else if ((device_mouse_x(device) >= posX + 304 && device_mouse_x(device) < posX + 320)) {
                            // Puede ser el 2, el 5 o el 8
                            indiceNPX = 1;
                        } else if ((device_mouse_x(device) >= posX + 320 && device_mouse_x(device) < posX + 336)) {
                            // Puede ser el 3, el 6 o el 9
                            indiceNPX = 2;
                        }
                        
                        if ((device_mouse_y(device) >= posY + 74 && device_mouse_y(device) < posY + 89)) {
                            // Puede ser el 1, el 2 o el 3
                            indiceNPY = 0;
                        } else if ((device_mouse_y(device) >= posY + 89 && device_mouse_y(device) < posY + 104)) {
                            // Puede ser el 4, el 5 o el 6
                            indiceNPY = 1;
                        } else if ((device_mouse_y(device) >= posY + 104 && device_mouse_y(device) < posY + 119)) {
                            // Puede ser el 7, el 8 o el 9
                            indiceNPY = 2;
                        } else if ((device_mouse_y(device) >= posY + 119 && device_mouse_y(device) < posY + 134)) {
                            // Puede ser el 0, o el botón "Borrar"
                            indiceNPY = 3;
                        }
                        
                        if (indiceNPX != -1 && indiceNPY != -1) {
                            if (numPad[indiceNPY, indiceNPX] != -1) {
                                var cantidadParcial = floor(real(campoCantidadS + string(numPad[indiceNPY, indiceNPX])));
                                if (cantidadParcial <= 10000) {
                                    if (campoCantidadS != "0") {
                                        campoCantidadS = string(cantidadParcial);    
                                    } else {
                                        campoCantidadS = string(numPad[indiceNPY, indiceNPX]);
                                    }                                    
                                }                                
                            } else {
                                campoCantidadS = "0";
                            }
                        }
                    
                    }              
                    
                } else if (
                (device_mouse_x(device) >= posX + 97 && device_mouse_x(device) <= posX + 113) &&
                (device_mouse_y(device) >= posY + 210 && device_mouse_y(device) <= posY + 223)
                ) {
                
                    // Vender
                    if (online_activo()) { online_comerciar("sell"); obj_control_devices.devicesL[device] = false; exit; }
                    
                    var cant = floor(real(campoCantidadS));
                    
                    if (sectorPj && cant > 0) {
                        if (indiceItem != -1) {
						var indiceItemAVender = obj_inventario.slots[indiceItem].indice;
						if (cant > obj_inventario.slots[indiceItem].cant)
							cant = obj_inventario.slots[indiceItem].cant
                            if (indiceItemAVender != -1 && obj_inventario.slots[indiceItem].cant >= cant && itemVendible(indiceItemAVender)) {
                            
                                clicMantenido = true;
                                deviceMantenido = device;
                                if (alarm[1] == -1) {
                                    alarm[1] = SECOND;
                                }
                            
                                if (obj_pj.oro + precioItem * cant <= obj_pj.oroMax) {
                                    obj_pj.oro += precioItem * cant;
                                } else {
                                    obj_pj.oro = obj_pj.oroMax;
                                }
												
								obj_skills_libres.mostrado = false;
                            
                                if (obj_inventario.slots[indiceItem].cant > cant) {
                                    obj_inventario.slots[indiceItem].cant -= cant;
                                } else {
                                
                                    if (indiceItemAVender == obj_inventario.seleccionado) {
                                        obj_inventario.seleccionado = -1;
                                    }
                                    
                                    if (indiceItem == obj_inventario.posSeleccionado) {
                                        obj_inventario.posSeleccionado = -1;
                                    }
                                    
                                    if (obj_inventario.slots[indiceItem].tipo == "ropa" && indiceItem == obj_pj.ropaEnInv) {
                                        obj_pj.desnudo = true;
                                        obj_pj.ropaActual = -1;
                                        obj_pj.ropaEnInv = -1;
                                        obj_pj.ropaIndexada = false;
                                    } else if (obj_inventario.slots[indiceItem].tipo == "arma" && indiceItem == obj_pj.armaEnInv) {
                                        obj_pj.armaActual = -1;
                                        obj_pj.armaEnInv = -1;
                                        obj_pj.sprArma = -1;
                                    } else if (obj_inventario.slots[indiceItem].tipo == "flecha" && indiceItem == obj_pj.flechaEnInv) {
                                        obj_pj.flechaActual = -1;
                                        obj_pj.flechaEnInv = -1;
                                    } else if (obj_inventario.slots[indiceItem].tipo == "casco" && indiceItem == obj_pj.cascoEnInv) {
                                        obj_pj.cascoActual = -1;
                                        obj_pj.cascoEnInv = -1;
                                    } else if (obj_inventario.slots[indiceItem].tipo == "escudo" && indiceItem == obj_pj.escudoEnInv) {
                                        obj_pj.escudoActual = -1;
                                        obj_pj.escudoEnInv = -1;
                                        obj_pj.sprEscudo = -1;
                                    } else if (obj_inventario.slots[indiceItem].tipo == "laud" && indiceItem == obj_pj.laudEnInv) {
                                        obj_pj.laudActual = -1;
                                        obj_pj.laudEnInv = -1;
                                        obj_pj.laudEquipado = false;
                                    } else if (obj_inventario.slots[indiceItem].tipo == "trabajo" && indiceItem == obj_pj.trabajoEnInv) {
                                        obj_pj.trabajoActual = -1;
                                        obj_pj.trabajoEnInv = -1;
                                        obj_pj.trabajoEquipado = false;
                                        obj_panel_trabajos.mostrado = false;
                                    }
                                    
                                    obj_inventario.slots[indiceItem] = crearSlotInv(-1, 0, false);
                                    
                                }
                            
                                intentarSubirSkillNatural(16, 0.35);
                                
                            }
                        }
                    }
                    
                } else if (
                (device_mouse_x(device) >= posX + 176 && device_mouse_x(device) <= posX + 192) &&
                (device_mouse_y(device) >= posY + 210 && device_mouse_y(device) <= posY + 223)
                ) {
                
                    // Comprar
                    if (online_activo()) { online_comerciar("buy"); obj_control_devices.devicesL[device] = false; exit; }
                    
                    var cant = floor(real(campoCantidadS));
                    
                    if (sectorNpc && cant > 0) {
                        if (indiceItem != -1) {
                            if (idPadre.slots[indiceItem].indice != -1) {
                                if (obj_pj.oro >= precioItem * cant) {
                                    
                                    var existe = false;
                    
                                    for (var i = 0; i < obj_inventario.maximoInv; i++) {
                                        if (obj_inventario.slots[i].indice == idPadre.slots[indiceItem].indice) {
                                            if (obj_inventario.slots[i].cant + cant <= 10000) {
                                                // Hay lugar en slot existente
                                                
                                                clicMantenido = true;
                                                deviceMantenido = device;
                                                if (alarm[1] == -1) {
                                                    alarm[1] = SECOND;
                                                }
                                                
                                                existe = true;
                                                obj_pj.oro -= precioItem * cant;
                                                obj_inventario.slots[i].cant += cant;
												
												obj_skills_libres.mostrado = false;
                                                
                                                if (intentarSubirSkillNatural(16, 0.35) > 0) {
                                                        var datosItem = descripcionItem(idPadre.slots[indiceItem].indice);
                                                                    
                                                            var modPrecio = 1;
                                                            
                                                            if (obj_pj.skills[16] >= 0 && obj_pj.skills[16] <= 10) {
                                                                modPrecio = 1;
                                                            } else if (obj_pj.skills[16] >= 11 && obj_pj.skills[16] <= 20) {
                                                                modPrecio = 1.15;
                                                            }  else if (obj_pj.skills[16] >= 21 && obj_pj.skills[16] <= 30) {
                                                                modPrecio = 1.25;
                                                            }  else if (obj_pj.skills[16] >= 31 && obj_pj.skills[16] <= 40) {
                                                                modPrecio = 1.35;
                                                            }  else if (obj_pj.skills[16] >= 41 && obj_pj.skills[16] <= 50) {
                                                                modPrecio = 1.45;
                                                            }  else if (obj_pj.skills[16] >= 51 && obj_pj.skills[16] <= 60) {
                                                                modPrecio = 1.5;
                                                            }  else if (obj_pj.skills[16] >= 61 && obj_pj.skills[16] <= 70) {
                                                                modPrecio = 1.65;
                                                            }  else if (obj_pj.skills[16] >= 71 && obj_pj.skills[16] <= 80) {
                                                                modPrecio = 1.75;
                                                            }  else if (obj_pj.skills[16] >= 81 && obj_pj.skills[16] <= 90) {
                                                                modPrecio = 1.85;
                                                            }  else if (obj_pj.skills[16] >= 91 && obj_pj.skills[16] <= 99) {
                                                                modPrecio = 1.95;
                                                            } else {
                                                                modPrecio = 2;
                                                            }
                                                            
                                                            precioItem = floor((datosItem.precio * 2) / modPrecio);
                                                            
                                                            if (precioItem <= 0) {
                                                                precioItem = 1;
                                                            }
                                                    }
                                                
                                                break;
                                            }
                                        }
                                    }
                                    
                                    if (!existe) {
                                        for (var i = 0; i < obj_inventario.maximoInv; i++) {
                                        
                                    if (obj_inventario.slots[i].indice == -1) {
                                    
                                        // Hay lugar en slot nuevo
                                        
                                        clicMantenido = true;
                                        deviceMantenido = device;
                                        if (alarm[1] == -1) {
                                            alarm[1] = SECOND;
                                        }
                                        
                                        obj_pj.oro -= precioItem * cant;
										
										obj_skills_libres.mostrado = false;
                                        
                                        obj_inventario.slots[i] = crearSlotInv(idPadre.slots[indiceItem].indice, cant, false);
                                                
                                                if (intentarSubirSkillNatural(16, 0.35) > 0) {
                                                        var datosItem = descripcionItem(idPadre.slots[indiceItem].indice);
                                                                    
                                                            var modPrecio = 1;
                                                            
                                                            if (obj_pj.skills[16] >= 0 && obj_pj.skills[16] <= 10) {
                                                                modPrecio = 1;
                                                            } else if (obj_pj.skills[16] >= 11 && obj_pj.skills[16] <= 20) {
                                                                modPrecio = 1.15;
                                                            }  else if (obj_pj.skills[16] >= 21 && obj_pj.skills[16] <= 30) {
                                                                modPrecio = 1.25;
                                                            }  else if (obj_pj.skills[16] >= 31 && obj_pj.skills[16] <= 40) {
                                                                modPrecio = 1.35;
                                                            }  else if (obj_pj.skills[16] >= 41 && obj_pj.skills[16] <= 50) {
                                                                modPrecio = 1.45;
                                                            }  else if (obj_pj.skills[16] >= 51 && obj_pj.skills[16] <= 60) {
                                                                modPrecio = 1.5;
                                                            }  else if (obj_pj.skills[16] >= 61 && obj_pj.skills[16] <= 70) {
                                                                modPrecio = 1.65;
                                                            }  else if (obj_pj.skills[16] >= 71 && obj_pj.skills[16] <= 80) {
                                                                modPrecio = 1.75;
                                                            }  else if (obj_pj.skills[16] >= 81 && obj_pj.skills[16] <= 90) {
                                                                modPrecio = 1.85;
                                                            }  else if (obj_pj.skills[16] >= 91 && obj_pj.skills[16] <= 99) {
                                                                modPrecio = 1.95;
                                                            } else {
                                                                modPrecio = 2;
                                                            }
                                                            
                                                            precioItem = floor((datosItem.precio * 2) / modPrecio);
                                                            
                                                            if (precioItem <= 0) {
                                                                precioItem = 1;
                                                            }
                                                    }
                                                
                                                break;
                                                
                                            }
                                            
                                        }  
                                    }
                                    
                                }
                            }
                        }
                    }
                    
                }
                
            }
            
            // //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            // MODO BANCO
            // //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            
            if (mostrado && modoBanco) {
            
                obj_hechizos.moviendoHechizo = false;
                
                var posX = global.render_x + get_render_width() * 0.5 - 144;
                var posY = global.render_y + get_render_height() * 0.5 - 113;
                
                if (
                (device_mouse_x(device) >= posX + 150 && device_mouse_x(device) <= posX + 279) &&
                (device_mouse_y(device) >= posY + 47 && device_mouse_y(device) <= posY + 207)
                ) {
                
                    var modY = posY + 47;
                
                    sectorNpc = false;
                    sectorPj = true;
                    
                    var _my = device_mouse_y(device) - modY;
                    if (_my >= 0 && _my < 160) indiceItem = floor(_my / 8); else indiceItem = -1;
                    
                    if (indiceItem != -1) {
                        if (obj_inventario.slots[indiceItem].indice != -1) {
                        
                            var datosItem = descripcionItem(obj_inventario.slots[indiceItem].indice);
                            descItem = datosItem.desc;
                            precioItem = datosItem.precio;
                            
                            datosItem = configurarItem(obj_inventario.slots[indiceItem].indice);
                            
                            var validoRaza = false;
                            var validoGenero = false;
                            var validoSkill = false;
                            var validoClase = false;
                            
                            // Raza
                            
                            if (
                            datosItem.raza == -1 ||
                            datosItem.raza == obj_pj.nroRaza
                            ) {
                                validoRaza = true;
                            } else {
                                switch (datosItem.raza) {
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
                            datosItem.genero == -1 ||
                            datosItem.genero == obj_pj.genero
                            ) {
                                validoGenero = true;
                            }
                            
                            // Clase
                            
                            switch (obj_pj.clase) {
                                case 0:
                                    if (datosItem.clases[0]) {
                                        validoClase = true;
                                    }
                                    break;
                                case 1:
                                    if (datosItem.clases[1]) {
                                        validoClase = true;
                                    }
                                    break;
                                case 2:
                                    if (datosItem.clases[2]) {
                                        validoClase = true;
                                    }
                                    break;
                                case 3:
                                    if (datosItem.clases[3]) {
                                        validoClase = true;
                                    }
                                    break;
                                case 4:
                                    if (datosItem.clases[4]) {
                                        validoClase = true;
                                    }
                                    break;
                                case 5:
                                    if (datosItem.clases[5]) {
                                        validoClase = true;
                                    }
                                    break;
                                case 6:
                                    if (datosItem.clases[6]) {
                                        validoClase = true;
                                    }
                                    break;
                                case 7:
                                    if (datosItem.clases[7]) {
                                        validoClase = true;
                                    }
                                    break;
                                case 8:
                                    if (datosItem.clases[8]) {
                                        validoClase = true;
                                    }
                                    break;
                            }
                            
                            // Skills
                            
                            if (obj_pj.skills[datosItem.nroSkill] >= datosItem.skillReq) {
                                validoSkill = true;
                            }
                            
                            // Valido todo
                            
                            if (validoSkill && validoClase && validoGenero && validoRaza) {
                            
                                if (obj_inventario.slots[indiceItem].indice == 144) {
                                    validoItem = "Podés usar este ítem (Ver manual para mas info.)";
                                } else if (obj_inventario.slots[indiceItem].indice >= SPELL_INDEX_BASE && obj_inventario.slots[indiceItem].indice <= SPELL_INDEX_BASE + 19) {
                                    validoItem = "Podés aprender este hechizo (Ver manual para mas info.)";
                                } else {
                                    validoItem = "Podés usar este ítem";
                                }
                                    
                            } else {
                                if (!validoRaza) {
                                    validoItem = "Tu raza no puede usar este ítem";
                                } else if (!validoGenero) {
                                    validoItem = "Tu género no puede usar este ítem";
                                } else if (!validoClase) {
                                    validoItem = "Tu clase no puede usar este ítem";
                                } else if (!validoSkill) {
                                    validoItem = "No tenés suficientes skillpoints para usar este ítem";
                                }
                            }
                            
                        }
                    }
                    
                } else if (
                (device_mouse_x(device) >= posX + 8 && device_mouse_x(device) <= posX + 137) &&
                (device_mouse_y(device) >= posY + 47 && device_mouse_y(device) <= posY + 207)
                ) {
                
                    var modY = posY + 47;
                
                    sectorNpc = true;
                    sectorPj = false;
                    
                    var _my = device_mouse_y(device) - modY;
                    if (_my >= 0 && _my < 160) indiceItem = floor(_my / 8); else indiceItem = -1;
                    
                    if (indiceItem != -1) {
                        if (idPadre.slots[indiceItem].indice != -1) {
                        
                            var datosItem = descripcionItem(idPadre.slots[indiceItem].indice);
                            descItem = datosItem.desc;
                                          
                            datosItem = configurarItem(idPadre.slots[indiceItem].indice);
                            
                            var validoRaza = false;
                            var validoGenero = false;
                            var validoSkill = false;
                            var validoClase = false;
                            
                            // Raza
                            
                            if (
                            datosItem.raza == -1 ||
                            datosItem.raza == obj_pj.nroRaza
                            ) {
                                validoRaza = true;
                            } else {
                                switch (datosItem.raza) {
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
                            datosItem.genero == -1 ||
                            datosItem.genero == obj_pj.genero
                            ) {
                                validoGenero = true;
                            }
                            
                            // Clase
                            
                            switch (obj_pj.clase) {
                                case 0:
                                    if (datosItem.clases[0]) {
                                        validoClase = true;
                                    }
                                    break;
                                case 1:
                                    if (datosItem.clases[1]) {
                                        validoClase = true;
                                    }
                                    break;
                                case 2:
                                    if (datosItem.clases[2]) {
                                        validoClase = true;
                                    }
                                    break;
                                case 3:
                                    if (datosItem.clases[3]) {
                                        validoClase = true;
                                    }
                                    break;
                                case 4:
                                    if (datosItem.clases[4]) {
                                        validoClase = true;
                                    }
                                    break;
                                case 5:
                                    if (datosItem.clases[5]) {
                                        validoClase = true;
                                    }
                                    break;
                                case 6:
                                    if (datosItem.clases[6]) {
                                        validoClase = true;
                                    }
                                    break;
                                case 7:
                                    if (datosItem.clases[7]) {
                                        validoClase = true;
                                    }
                                    break;
                                case 8:
                                    if (datosItem.clases[8]) {
                                        validoClase = true;
                                    }
                                    break;
                            }
                            
                            // Skills
                            
                            if (obj_pj.skills[datosItem.nroSkill] >= datosItem.skillReq) {
                                validoSkill = true;
                            }
                            
                            // Valido todo
                        
                            if (validoSkill && validoClase && validoGenero && validoRaza) {
                            
                                if (idPadre.slots[indiceItem].indice == 144) {
                                    validoItem = "Podés usar este ítem (Ver manual para mas info.)";
                                } else if (idPadre.slots[indiceItem].indice >= SPELL_INDEX_BASE && idPadre.slots[indiceItem].indice <= SPELL_INDEX_BASE + 19) {
                                    validoItem = "Podés aprender este hechizo (Ver manual para mas info.)";
                                } else {
                                    validoItem = "Podés usar este ítem";
                                }
                            
                                
                            } else {
                                if (!validoRaza) {
                                    validoItem = "Tu raza no puede usar este ítem";
                                } else if (!validoGenero) {
                                    validoItem = "Tu género no puede usar este ítem";
                                } else if (!validoClase) {
                                    validoItem = "Tu clase no puede usar este ítem";
                                } else if (!validoSkill) {
                                    validoItem = "No tenés suficientes skillpoints para usar este ítem";
                                }
                            }
                            
                        }
                    }
                    
                } else if (device_mouse_x(device) >= posX + 272 && device_mouse_y(device) <= posY + 15) {
                    mostrado = false;   
                    image_index = 0;
                    campoCantidadS = "1";
                } else if (
                (device_mouse_x(device) >= posX + 122 && device_mouse_x(device) <= posX + 167) &&
                (device_mouse_y(device) >= posY + 210 && device_mouse_y(device) <= posY + 223)
                ) {
                
                    // Abro o cierro el numpad
                     
                    if (image_index == 0) {
                        image_index = 1;
                    } else {
                        image_index = 0;
                    }                    
                    
                    campoCantidadS = "0";
                    
                } else if (                
                (device_mouse_x(device) >= posX + 288 && device_mouse_x(device) <= posX + 336) &&
                (device_mouse_y(device) >= posY + 74 && device_mouse_y(device) <= posY + 134)
                ) {
                
                    // Escribo con el numpad
                     
                    if (image_index == 1) {
                        
                        var indiceNPX = -1;
                        var indiceNPY = -1;
                    
                        if ((device_mouse_x(device) >= posX + 288 && device_mouse_x(device) < posX + 304)) {
                            // Puede ser el 1, el 4 o el 7
                            indiceNPX = 0;
                        } else if ((device_mouse_x(device) >= posX + 304 && device_mouse_x(device) < posX + 320)) {
                            // Puede ser el 2, el 5 o el 8
                            indiceNPX = 1;
                        } else if ((device_mouse_x(device) >= posX + 320 && device_mouse_x(device) < posX + 336)) {
                            // Puede ser el 3, el 6 o el 9
                            indiceNPX = 2;
                        }
                        
                        if ((device_mouse_y(device) >= posY + 74 && device_mouse_y(device) < posY + 89)) {
                            // Puede ser el 1, el 2 o el 3
                            indiceNPY = 0;
                        } else if ((device_mouse_y(device) >= posY + 89 && device_mouse_y(device) < posY + 104)) {
                            // Puede ser el 4, el 5 o el 6
                            indiceNPY = 1;
                        } else if ((device_mouse_y(device) >= posY + 104 && device_mouse_y(device) < posY + 119)) {
                            // Puede ser el 7, el 8 o el 9
                            indiceNPY = 2;
                        } else if ((device_mouse_y(device) >= posY + 119 && device_mouse_y(device) < posY + 134)) {
                            // Puede ser el 0, o el botón "Borrar"
                            indiceNPY = 3;
                        }
                        
                        if (indiceNPX != -1 && indiceNPY != -1) {
                            if (numPad[indiceNPY, indiceNPX] != -1) {
                                var cantidadParcial = floor(real(campoCantidadS + string(numPad[indiceNPY, indiceNPX])));
                                if (cantidadParcial <= 10000) {
                                    if (campoCantidadS != "0") {
                                        campoCantidadS = string(cantidadParcial);    
                                    } else {
                                        campoCantidadS = string(numPad[indiceNPY, indiceNPX]);
                                    }                                    
                                }                                
                            } else {
                                campoCantidadS = "0";
                            }
                        }
                    
                    }             
                    
                } else if (
                (device_mouse_x(device) >= posX + 97 && device_mouse_x(device) <= posX + 113) &&
                (device_mouse_y(device) >= posY + 210 && device_mouse_y(device) <= posY + 223)
                ) {
                
                    // Depositar
                    if (online_activo()) { online_comerciar("deposit"); obj_control_devices.devicesL[device] = false; exit; }
                    
                    var cant = floor(real(campoCantidadS));
                    
                    if (sectorPj && cant > 0) {
                        if (indiceItem != -1) {
						if (cant > obj_inventario.slots[indiceItem].cant)
							cant = obj_inventario.slots[indiceItem].cant
                            if (obj_inventario.slots[indiceItem].indice != -1 && obj_inventario.slots[indiceItem].cant >= cant) {
                            
                                var valido = false;
                                var existe = false;
                    
                                for (var i = 0; i < MAX_SLOTS; i++) {
                                    if (idPadre.slots[i].indice == obj_inventario.slots[indiceItem].indice) {
                                        if (idPadre.slots[i].cant + cant <= 10000) {
                                        
                                            // Hay lugar en slot existente
                                            
                                            clicMantenido = true;
                                            deviceMantenido = device;
                                            if (alarm[1] == -1) {
                                                alarm[1] = SECOND;
                                            }
                                            
                                            existe = true;
                                            idPadre.slots[i].cant += cant;
                                            valido = true;
                                            break;
                                            
                                        }
                                    }
                                }
                                
                                if (!existe) {
                                    for (var i = 0; i < MAX_SLOTS; i++) {
                                    
                                        if (idPadre.slots[i].indice == -1) {
                                        
                                            // Hay lugar en slot nuevo
                                            
                                            clicMantenido = true;
                                            deviceMantenido = device;
                                            if (alarm[1] == -1) {
                                                alarm[1] = SECOND;
                                            }
                                            
                                            datosItem = configurarItem(obj_inventario.slots[indiceItem].indice);
                                            
                                            idPadre.slots[i] = crearSlotNpc(obj_inventario.slots[indiceItem].indice, cant, datosItem.nombre);
                                            
                                            valido = true;
                                            
                                            break;
                                            
                                        }
                                        
                                    }  
                                }
                            
                                if (valido) {
                                    
                                if (obj_inventario.slots[indiceItem].cant > cant) {
                                    obj_inventario.slots[indiceItem].cant -= cant;
                                    } else {
                                    
                                        if (obj_inventario.slots[indiceItem].indice == obj_inventario.seleccionado) {
                                            obj_inventario.seleccionado = -1;
                                        }
                                        
                                        if (indiceItem == obj_inventario.posSeleccionado) {
                                            obj_inventario.posSeleccionado = -1;
                                        }
                                        
                                    if (obj_inventario.slots[indiceItem].tipo == "ropa" && indiceItem == obj_pj.ropaEnInv) {
                                            obj_pj.desnudo = true;
                                            obj_pj.ropaActual = -1;
                                            obj_pj.ropaEnInv = -1;
                                            obj_pj.ropaIndexada = false;
                                        } else if (obj_inventario.slots[indiceItem].tipo == "arma" && indiceItem == obj_pj.armaEnInv) {
                                            obj_pj.armaActual = -1;
                                            obj_pj.armaEnInv = -1;
                                        } else if (obj_inventario.slots[indiceItem].tipo == "flecha" && indiceItem == obj_pj.flechaEnInv) {
                                            obj_pj.flechaActual = -1;
                                            obj_pj.flechaEnInv = -1;
                                        } else if (obj_inventario.slots[indiceItem].tipo == "casco" && indiceItem == obj_pj.cascoEnInv) {
                                            obj_pj.cascoActual = -1;
                                            obj_pj.cascoEnInv = -1;
                                        } else if (obj_inventario.slots[indiceItem].tipo == "escudo" && indiceItem == obj_pj.escudoEnInv) {
                                            obj_pj.escudoActual = -1;
                                            obj_pj.escudoEnInv = -1;
                                        } else if (obj_inventario.slots[indiceItem].tipo == "laud" && indiceItem == obj_pj.laudEnInv) {
                                            obj_pj.laudActual = -1;
                                            obj_pj.laudEnInv = -1;
                                            obj_pj.laudEquipado = false;
                                        } else if (obj_inventario.slots[indiceItem].tipo == "trabajo" && indiceItem == obj_pj.trabajoEnInv) {
                                            obj_pj.trabajoActual = -1;
                                            obj_pj.trabajoEnInv = -1;
                                            obj_pj.trabajoEquipado = false;
                                            obj_panel_trabajos.mostrado = false;
                                        }
                                        
                                        obj_inventario.slots[indiceItem] = crearSlotInv(-1, 0, false);
                                        
                                    }
                                
                                }
                                
                            }
                        }
                    }
                    
                } else if (
                (device_mouse_x(device) >= posX + 176 && device_mouse_x(device) <= posX + 192) &&
                (device_mouse_y(device) >= posY + 210 && device_mouse_y(device) <= posY + 223)
                ) {
                
                    // Retirar
                    if (online_activo()) { online_comerciar("withdraw"); obj_control_devices.devicesL[device] = false; exit; }
                    
                    var cant = floor(real(campoCantidadS));
                    
                    if (sectorNpc && cant > 0) {
                        if (indiceItem != -1) {
							if (cant > idPadre.slots[indiceItem].cant)
								cant = idPadre.slots[indiceItem].cant;
                            if (idPadre.slots[indiceItem].indice != -1 && idPadre.slots[indiceItem].cant >= cant) {
                                    
                                var valido = false;
                                var existe = false;
                
                                for (var i = 0; i < obj_inventario.maximoInv; i++) {
                                    if (obj_inventario.slots[i].indice == idPadre.slots[indiceItem].indice) {
                                        if (obj_inventario.slots[i].cant + cant <= 10000) {
                                        
                                            // Hay lugar en slot existente
                                            
                                            clicMantenido = true;
                                            deviceMantenido = device;
                                            if (alarm[1] == -1) {
                                                alarm[1] = SECOND;
                                            }
                                            
                                            existe = true;
                                            obj_inventario.slots[i].cant += cant;
                                            valido = true;
                                            break;
                                            
                                        }
                                    }
                                }
                                
                                if (!existe) {
                                    for (var i = 0; i < obj_inventario.maximoInv; i++) {
                                    
                                    if (obj_inventario.slots[i].indice == -1) {
                                    
                                        // Hay lugar en slot nuevo
                                        
                                        clicMantenido = true;
                                        deviceMantenido = device;
                                        if (alarm[1] == -1) {
                                            alarm[1] = SECOND;
                                        }
                                        
                                        obj_inventario.slots[i] = crearSlotInv(idPadre.slots[indiceItem].indice, cant, false);
                                            
                                            valido = true;
                                            
                                            break;
                                            
                                        }
                                        
                                    }  
                                }
                                
                                if (valido) {
                                
                                    if (idPadre.slots[indiceItem].cant > cant) {
                                        idPadre.slots[indiceItem].cant -= cant;
                                    } else {                            
                                        idPadre.slots[indiceItem] = crearSlotNpc(-1, 0, "Vacío");                            
                                    }
                                
                                }
                                
                            }
                        }
                    }
                    
                }
                
            }
                
            obj_control_devices.devicesL[device] = false;
        
        }
        
    }

}
