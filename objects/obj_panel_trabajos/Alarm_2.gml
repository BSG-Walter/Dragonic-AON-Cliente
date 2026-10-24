if (online_activo()) exit;
/// @description  Fabricar rápidamente

if (clicMantenido) {
    if (deviceMantenido != -1) {
    
        var device = deviceMantenido;
    
        var posX = global.render_x + get_render_width() * 0.5 - 144;
        var posY = global.render_y + get_render_height() * 0.5 - 113;
        
        if (
        (device_mouse_x(device) >= posX + 122 && device_mouse_x(device) <= posX + 178) &&
        (device_mouse_y(device) >= posY + 211 && device_mouse_y(device) <= posY + 221)
        ) {
        
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
                                    
                                    obj_inventario.slots[i] = crearSlotInv(listaItems[indiceItem], 1, false);
                                    
                                    valido = true;
                                    
                                    break;
                                    
                                }
                            }  
                        }
                        
                        if (valido) {
                         
                            if (intentarSubirSkillNatural(indiceSkill, modo == 2 ? 1.0 : 0.35) > 0) alarm[0] = 1;
                        
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
                                    
                                    obj_inventario.slots[i] = crearSlotInv(listaItems[indiceItem], 1, false);
                                    
                                    valido = true;
                                    
                                    break;
                                    
                                }
                            }  
                        }
                        
                        if (valido) {
                         
                            if (intentarSubirSkillNatural(10, 0.55) > 0) alarm[0] = 1;
                            
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
    
        alarm[2] = 2;
        
    }
}

/* */
/*  */