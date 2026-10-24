if (online_activo() && instance_exists(obj_pausa)) exit;
/// @description  Transferir rápidamente

if (clicMantenido) {
    if (deviceMantenido != -1) {
    
        var device = deviceMantenido;
    
        var posX = global.render_x + get_render_width() * 0.5 - 144;
        var posY = global.render_y + get_render_height() * 0.5 - 113;
        
        if (!modoBanco) {
        
            if (
            (device_mouse_x(device) >= posX + 97 && device_mouse_x(device) <= posX + 113) &&
            (device_mouse_y(device) >= posY + 210 && device_mouse_y(device) <= posY + 223)
            ) {
            
                // Vender
                    if (online_activo()) { online_comerciar("sell"); obj_control_devices.devicesL[device] = false; exit; }
                
                var cant = floor(real(campoCantidadS));
                
                if (sectorPj && cant > 0) {
                    if (indiceItem != -1) {
						if (cant > obj_inventario.slots[indiceItem].cant)
							cant = obj_inventario.slots[indiceItem].cant
						var indiceItemAVender = obj_inventario.slots[indiceItem].indice;
                        if (indiceItemAVender != -1 && obj_inventario.slots[indiceItem].cant >= cant && itemVendible(indiceItemAVender)) {
                        
                            if (obj_pj.oro + precioItem * cant <= obj_pj.oroMax) {
                                obj_pj.oro += precioItem * cant;
                            } else {
                                obj_pj.oro = obj_pj.oroMax;
                            }
												
							obj_skills_libres.mostrado = false;
                        
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
        
        } else {
            
            if (
            (device_mouse_x(device) >= posX + 97 && device_mouse_x(device) <= posX + 113) &&
            (device_mouse_y(device) >= posY + 210 && device_mouse_y(device) <= posY + 223)
            ) {
            
                // Depositar
                    if (online_activo()) { online_comerciar("deposit"); obj_control_devices.devicesL[device] = false; exit; }
                
                var cant = floor(real(campoCantidadS));
                
                if (sectorPj && cant > 0) {
                    if (indiceItem != -1) {
						if (cant > obj_inventario.slots[indiceItem].cant)
							cant = obj_inventario.slots[indiceItem].cant;
                        if (obj_inventario.slots[indiceItem].indice != -1 && obj_inventario.slots[indiceItem].cant >= cant) {
                        
                            var valido = false;
                            var existe = false;
                
                                for (var i = 0; i < MAX_SLOTS; i++) {
                                    if (idPadre.slots[i].indice == obj_inventario.slots[indiceItem].indice) {
                                    if (idPadre.slots[i].cant + cant <= 10000) {
                                    
                                        // Hay lugar en slot existente
                                        
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
    
        alarm[0] = 2;
        
    }
}
