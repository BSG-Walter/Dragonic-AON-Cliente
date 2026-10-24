if (online_activo() && clicMantenido) {
    if (!mostrado || deviceMantenido < 0 || !device_mouse_check_button(deviceMantenido, mb_left)) {
        clicMantenido = false;
        deviceMantenido = -1;
        online_accion({op: "stop_work"});
    }
}
/// @description  Control general / Control mouse

if (mostrado) {
    
    if (posicionItem != -1) {
        if (!obj_inventario.slots[posicionItem].equipado) {
            mostrado = false;
            posicionItem = -1;
        }
    }

    x = global.render_x + get_render_width() * 0.5;
    y = global.render_y + get_render_height() * 0.5;   
     
} else {
    idPadre = -1;
    indiceItem = -1;
    descItem = "";
    validoItem = "";     
    elementosItem = "";
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

            if (mostrado) {
            
                obj_hechizos.moviendoHechizo = false;
                
                var posX = global.render_x + get_render_width() * 0.5 - 144;
                var posY = global.render_y + get_render_height() * 0.5 - 113;
                
                if (
                (device_mouse_x(device) >= posX + 8 && device_mouse_x(device) <= posX + 279) &&
                (device_mouse_y(device) >= posY + 47 && device_mouse_y(device) <= posY + 207)
                ) {
                
                    var modY = posY + 47;
                    
                    indiceItem = -1;
                    
                    if (device_mouse_y(device) >= modY && device_mouse_y(device) < modY + 8 * 1) {
                        indiceItem = 0;
                    } else if (device_mouse_y(device) >= modY + 8 * 1 && device_mouse_y(device) < modY + 8 * 2) {
                        indiceItem = 1;
                    } else if (device_mouse_y(device) >= modY + 8 * 2 && device_mouse_y(device) < modY + 8 * 3) {
                        indiceItem = 2;
                    } else if (device_mouse_y(device) >= modY + 8 * 3 && device_mouse_y(device) < modY + 8 * 4) {
                        indiceItem = 3;
                    } else if (device_mouse_y(device) >= modY + 8 * 4 && device_mouse_y(device) < modY + 8 * 5) {
                        indiceItem = 4;
                    } else if (device_mouse_y(device) >= modY + 8 * 5 && device_mouse_y(device) < modY + 8 * 6) {
                        indiceItem = 5;
                    } else if (device_mouse_y(device) >= modY + 8 * 6 && device_mouse_y(device) < modY + 8 * 7) {
                        indiceItem = 6;
                    } else if (device_mouse_y(device) >= modY + 8 * 7 && device_mouse_y(device) < modY + 8 * 8) {
                        indiceItem = 7;
                    } else if (device_mouse_y(device) >= modY + 8 * 8 && device_mouse_y(device) < modY + 8 * 9) {
                        indiceItem = 8;
                    } else if (device_mouse_y(device) >= modY + 8 * 9 && device_mouse_y(device) < modY + 8 * 10) {
                        indiceItem = 9;
                    } else if (device_mouse_y(device) >= modY + 8 * 10 && device_mouse_y(device) < modY + 8 * 11) {
                        indiceItem = 10;
                    } else if (device_mouse_y(device) >= modY + 8 * 11 && device_mouse_y(device) < modY + 8 * 12) {
                        indiceItem = 11;
                    } else if (device_mouse_y(device) >= modY + 8 * 12 && device_mouse_y(device) < modY + 8 * 13) {
                        indiceItem = 12;
                    } else if (device_mouse_y(device) >= modY + 8 * 13 && device_mouse_y(device) < modY + 8 * 14) {
                        indiceItem = 13;
                    } else if (device_mouse_y(device) >= modY + 8 * 14 && device_mouse_y(device) < modY + 8 * 15) {
                        indiceItem = 14;
                    } else if (device_mouse_y(device) >= modY + 8 * 15 && device_mouse_y(device) < modY + 8 * 16) {
                        indiceItem = 15;
                    } else if (device_mouse_y(device) >= modY + 8 * 16 && device_mouse_y(device) < modY + 8 * 17) {
                        indiceItem = 16;
                    } else if (device_mouse_y(device) >= modY + 8 * 17 && device_mouse_y(device) < modY + 8 * 18) {
                        indiceItem = 17;
                    } else if (device_mouse_y(device) >= modY + 8 * 18 && device_mouse_y(device) < modY + 8 * 19) {
                        indiceItem = 18;
                    } else if (device_mouse_y(device) >= modY + 8 * 19 && device_mouse_y(device) < modY + 8 * 20) {
                        indiceItem = 19;
                    }
                    
                    if (indiceItem != -1) {
                        if (listaItems[indiceItem] != -1) {
                        
                            var datosItem = descripcionItem(listaItems[indiceItem]);
                            descItem = datosItem.desc;
                            
                            datosItem = datosTrabajo(listaItems[indiceItem]);
                            
                            if (
                            listaItems[indiceItem] == 20 || listaItems[indiceItem] == 24 || listaItems[indiceItem] == 25 || listaItems[indiceItem] == 26 || listaItems[indiceItem] == 27 ||
                            listaItems[indiceItem] == 29 || listaItems[indiceItem] == 31 || listaItems[indiceItem] == 32 || listaItems[indiceItem] == 217 || listaItems[indiceItem] == 140 || listaItems[indiceItem] == 144 || listaItems[indiceItem] == 227
                            ) {
                                // Carpintería
                                elementosItem = "Leña: " + string(datosItem.consume1);
                            } else if (
                            listaItems[indiceItem] == 41 || listaItems[indiceItem] == 42 || listaItems[indiceItem] == 43 || listaItems[indiceItem] == 44 || listaItems[indiceItem] == 45 || 
                            listaItems[indiceItem] == 61 || listaItems[indiceItem] == 66 || listaItems[indiceItem] == 67 || listaItems[indiceItem] == 68 || listaItems[indiceItem] == 69 || 
                            listaItems[indiceItem] == 70 || listaItems[indiceItem] == 97
                            ) {
                                // Sastrería
                                elementosItem = "Pieles de lobo: " + string(datosItem.consume1);
                            } else {
                                // Herrería
                                if (datosItem.consume1 > 0) {
                                    elementosItem = "Hierro: " + string(datosItem.consume1) + " ";
                                }
                                if (datosItem.consume2 > 0) {
                                    elementosItem += "Plata: " + string(datosItem.consume2) + " ";
                                }
                                if (datosItem.consume3 > 0) {
                                    elementosItem += "Oro: " + string(datosItem.consume3);
                                }
                            }
                                          
                            datosItem = configurarItem(listaItems[indiceItem]);
                            
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
                            
                                if (listaItems[indiceItem] == 144) {
                                    validoItem = "Podés usar este ítem (Ver manual para mas info.)";
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
                } else if (
                (device_mouse_x(device) >= posX + 122 && device_mouse_x(device) <= posX + 178) &&
                (device_mouse_y(device) >= posY + 211 && device_mouse_y(device) <= posY + 221)
                ) {
                
                    if (online_activo()) {
                        if (indiceItem >= 0 && listaItems[indiceItem] >= 0
                            && online_accion({op: "craft", item: listaItems[indiceItem]})) {
                            clicMantenido = true;
                            deviceMantenido = device;
                        }
                        obj_control_devices.devicesL[device] = false;
                        exit;
                    }
                    // Fabricar
                    
                    if (indiceItem != -1) {
                    
                        if (modo == 0 || modo == 2) {
                            
                            // Carpintería / Sastrería
                        
                            var indiceMaterial = 146;
                            var indiceSkill = 9;
                        
                            if (modo == 2) {
                                indiceMaterial = 28;
                                indiceSkill = 15;
                            }
                        
                            var materialesAcumulados = 0;
                        
                            for (var i = 0; i < obj_inventario.maximoInv; i++) {
                                if (obj_inventario.slots[i].indice == indiceMaterial) {
                                    materialesAcumulados += obj_inventario.slots[i].cant;
                                }    
                            }
                            
                            var datosItem = datosTrabajo(listaItems[indiceItem]);
                            
                            if (materialesAcumulados >= datosItem.consume1) {
                    
                                var totalMeterialesNecesarios = datosItem.consume1;
                                var valido = false;
                                var existe = false;
                            
                                for (var i = 0; i < obj_inventario.maximoInv; i++) {
                                    if (obj_inventario.slots[i].indice == listaItems[indiceItem]) {
                                        if (obj_inventario.slots[i].cant + 1 <= 10000) {
                                        
                                            // Hay lugar en slot existente
                                            
                                            clicMantenido = true;
                                            deviceMantenido = device;
                                            if (alarm[1] == -1) {
                                                alarm[1] = SECOND;
                                            }
                                            
                                            existe = true;
                                            obj_inventario.slots[i].cant++;
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
                                            
                                            obj_inventario.slots[i] = crearSlotInv(listaItems[indiceItem], 1, false);
                                            
                                            valido = true;
                                            
                                            break;
                                            
                                        }
                                    }  
                                }
                                
                                if (valido) {
                                
                                    if (modo == 2) { intentarSubirSkillNatural(indiceSkill, 1.0); } else { intentarSubirSkillNatural(indiceSkill, 0.35); }
                                
                                    for (var i = 0; i < obj_inventario.maximoInv; i++) {
                                        if (obj_inventario.slots[i].indice == indiceMaterial) {
                                            if (obj_inventario.slots[i].cant > totalMeterialesNecesarios) {
                                            
                                                obj_inventario.slots[i].cant -= totalMeterialesNecesarios;
                                                totalMeterialesNecesarios = 0;
                                                break;
                                                
                                            } else if (obj_inventario.slots[i].cant == totalMeterialesNecesarios) {
                                                
                                                obj_inventario.slots[i].cant -= totalMeterialesNecesarios;
                                                totalMeterialesNecesarios = 0;
                                            
                                                if (obj_inventario.slots[i].indice == obj_inventario.seleccionado) {
                                                    obj_inventario.seleccionado = -1;
                                                }
                                                
                                                if (i == obj_inventario.posSeleccionado) {
                                                    obj_inventario.posSeleccionado = -1;
                                                }
                                            
                                                obj_inventario.slots[i] = crearSlotInv(-1, 0, false);              
                                                
                                                break;
                                                
                                            } else {
                                            
                                                totalMeterialesNecesarios -= obj_inventario.slots[i].cant;
                                            
                                                if (obj_inventario.slots[i].indice == obj_inventario.seleccionado) {
                                                    obj_inventario.seleccionado = -1;
                                                }
                                                
                                                if (i == obj_inventario.posSeleccionado) {
                                                    obj_inventario.posSeleccionado = -1;
                                                }
                                            
                                                obj_inventario.slots[i] = crearSlotInv(-1, 0, false);  
                                                
                                            }
                                        }    
                                    }
                                
                                }
                                
                            }
                            
                        } else {
                        
                            // Herrería
                            
                            /*
                            
                                Lingotes:
                            
                                Hierro = 151;
                                Plata = 152;
                                Oro = 153;
                                
                            */
                        
                            var lingotesHAcumulados = 0;
                            var lingotesPAcumulados = 0;
                            var lingotesOAcumulados = 0;
                        
                            for (var i = 0; i < obj_inventario.maximoInv; i++) {
                                if (obj_inventario.slots[i].indice == 151 || obj_inventario.slots[i].indice == 152 || obj_inventario.slots[i].indice == 153) {
                                    switch (obj_inventario.slots[i].indice) {
                                        case 151:                    
                                            lingotesHAcumulados += obj_inventario.slots[i].cant;
                                            break;
                                        case 152:                    
                                            lingotesPAcumulados += obj_inventario.slots[i].cant;
                                            break;
                                        case 153:                    
                                            lingotesOAcumulados += obj_inventario.slots[i].cant;
                                            break;
                                    }
                                }    
                            }
                            
                            var datosItem = datosTrabajo(listaItems[indiceItem]);
                            
                            if (
                            lingotesHAcumulados >= datosItem.consume1 && 
                            lingotesPAcumulados >= datosItem.consume2 && 
                            lingotesOAcumulados >= datosItem.consume3
                            ) {
                    
                                var totalMaterialesNecesarios;
                                totalMaterialesNecesarios[0] = datosItem.consume1;
                                totalMaterialesNecesarios[1] = datosItem.consume2;
                                totalMaterialesNecesarios[2] = datosItem.consume3;
                                
                                var iAux = 0;
                                var indiceMaterial = 151;
                                var valido = false;
                                var existe = false;
                            
                                for (var i = 0; i < obj_inventario.maximoInv; i++) {
                                    if (obj_inventario.slots[i].indice == listaItems[indiceItem]) {
                                        if (obj_inventario.slots[i].cant + 1 <= 10000) {
                                        
                                            // Hay lugar en slot existente
                                            
                                            clicMantenido = true;
                                            deviceMantenido = device;
                                            if (alarm[1] == -1) {
                                                alarm[1] = SECOND;
                                            }
                                            
                                            existe = true;
                                            obj_inventario.slots[i].cant++;
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
                                            
                                            obj_inventario.slots[i] = crearSlotInv(listaItems[indiceItem], 1, false);
                                            
                                            valido = true;
                                            
                                            break;
                                            
                                        }
                                    }  
                                }
                                
                                if (valido) {
                                
                                    intentarSubirSkillNatural(10, 0.55); alarm[0] = 1;
                                    
                                    repeat (3) {
                                    
                                        for (var i = 0; i < obj_inventario.maximoInv; i++) {
                                            if (obj_inventario.slots[i].indice == indiceMaterial) {
                                                if (obj_inventario.slots[i].cant > totalMaterialesNecesarios[iAux]) {
                                                
                                                    obj_inventario.slots[i].cant -= totalMaterialesNecesarios[iAux];
                                                    totalMaterialesNecesarios[iAux] = 0;
                                                    break;
                                                    
                                                } else if (obj_inventario.slots[i].cant == totalMaterialesNecesarios[iAux]) {
                                                    
                                                    obj_inventario.slots[i].cant -= totalMaterialesNecesarios[iAux];
                                                    totalMaterialesNecesarios[iAux] = 0;
                                                
                                                    if (obj_inventario.slots[i].indice == obj_inventario.seleccionado) {
                                                        obj_inventario.seleccionado = -1;
                                                    }
                                                    
                                                    if (i == obj_inventario.posSeleccionado) {
                                                        obj_inventario.posSeleccionado = -1;
                                                    }
                                                
                                                    obj_inventario.slots[i] = crearSlotInv(-1, 0, false);              
                                                    
                                                    break;
                                                    
                                                } else {
                                                
                                                    totalMaterialesNecesarios[iAux] -= obj_inventario.slots[i].cant;
                                                
                                                    if (obj_inventario.slots[i].indice == obj_inventario.seleccionado) {
                                                        obj_inventario.seleccionado = -1;
                                                    }
                                                    
                                                    if (i == obj_inventario.posSeleccionado) {
                                                        obj_inventario.posSeleccionado = -1;
                                                    }
                                                
                                                    obj_inventario.slots[i] = crearSlotInv(-1, 0, false);  
                                                    
                                                }
                                            }    
                                        }
                                        
                                        iAux++;
                                        indiceMaterial++;
                                    
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

/* */
/*  */