if (online_activo() || global.online_exportando) exit;
/// @description  Baja el tiempo de inmovilidad / parálisis de todos los NPCs / simulación movimiento

var datosIAMod;

for (var k = 0; k < totalMultiIA; k++) {

    datosIAMod = globalIA[k];

    if (datosIAMod.x != -1) {
        
        if (datosIAMod.roomIA != room && !datosIAMod.puedeCrear) {
        
            // Inmovilidad / Parálisis
        
            if (datosIAMod.alarm4 != -1) {
                if (datosIAMod.alarm4 > 1) {
                    datosIAMod.alarm4 -= 1;
                } else {
                    datosIAMod.inmovilizado = false;
                }
            }
            
            if (obj_pj.nivel >= 24) {
                if (datosIAMod.alarm8 != -1) {
                    if (datosIAMod.alarm8 > 1) {
                        datosIAMod.alarm8 -= 1;
                    } else {
                        datosIAMod.alarm8 = 240;
                        datosIAMod.inmovilizado = false;
                    }
                }
            }
            
            // Tiempo lejos del PJ
    
            datosIAMod.tiempoLejosPJ += 1;
            if (!datosIAMod.enemigo) {
                if (datosIAMod.tiempoLejosPJ >= 2700) {
                    datosIAMod.x = -1;
                    obj_respawn_personas.alarm[0] = 1;
                }
            } else {
                if (datosIAMod.tiempoLejosPJ >= 3600) {
                    datosIAMod.x = -1;
                    obj_respawn_personas.alarm[0] = 1;
                }
            }
            
            // Simulación de movimiento
            
            crea = false;
                
            if (datosIAMod.TPCerca == -1) {
            
                // Teletransporte por obj_telep
            
                if (/*!datosIAMod.enemigo || */!datosIAMod.agitando || PJInvi || obj_pj.muerto) {
                
                    // Cambio la dirección de la IA por la inversa del PJ
                
                    if (direccionPJ == datosIAMod.direccion) {
                        switch (direccionPJ) {
                            case 0:
                                datosIAMod.direccion = 1;
                                break;
                            case 1:
                                datosIAMod.direccion = 0;
                                break;
                            case 2:
                                datosIAMod.direccion = 3;
                                break;
                            case 3:
                                datosIAMod.direccion = 2;
                                break;
                        }
                    }
                
                    if (random(10) > 5) {
                    
                        // Hago movimientos random en el caso de que no sea enemigo, este invi o no esté agitando
                    
                        switch (datosIAMod.direccion) {
                            case 0:
                                datosIAMod.y += 2;
                                if (datosIAMod.y >= 2224) {
                                    datosIAMod.y = 2192;
                                }
                                break;
                            case 1:
                                datosIAMod.y -= 2;
                                if (datosIAMod.y < 144) {
                                    datosIAMod.y = 176;
                                }
                                break;
                            case 2:
                                datosIAMod.x -= 2;
                                if (datosIAMod.x < 320) {
                                    datosIAMod.x = 352;
                                }
                                break;
                            case 3:
                                datosIAMod.x += 2;
                                if (datosIAMod.x >= 2080) {
                                    datosIAMod.x = 2048;
                                }
                                break;
                        }
                        
                    }            
                
                    // direccionPJ = -1;
                    
                } else if (direccionPJ != -1 /*&& datosIAMod.enemigo*/ && datosIAMod.agitando && !PJInvi && !datosIAMod.inmovilizado && datosIAMod.sigueAlOtroMapa && !obj_pj.muerto) {
                
                    // Si es enemigo, agita, el PJ no esta invi y la IA no esta inmo...
                
                    switch (direccionPJ) {
                        case 0:
                            datosIAMod.y += 2;
                            if (datosIAMod.y >= 2224) {
                                crea = true;
                                datosIAMod.y = 176;
                            }
                            break;
                        case 1:
                            datosIAMod.y -= 2;
                            if (datosIAMod.y < 144) {
                                crea = true;
                                datosIAMod.y = 2192;
                            }
                            break;
                        case 2:
                            datosIAMod.x -= 2;
                            if (datosIAMod.x < 320) {
                                crea = true;
                                datosIAMod.x = 2064;
                            }
                            break;
                        case 3:
                            datosIAMod.x += 2;
                            if (datosIAMod.x >= 2080) {
                                crea = true;
                                datosIAMod.x = 320;
                            }
                            break;
                    }
                    
                    datosIAMod.direccion = direccionPJ;
                    
                    if (crea) {
                        datosIAMod.puedeCrear = true;
						globalIA[k] = datosIAMod;
                        crearIADelMundo();
                    }
                    
                }
            
            } else {
            
                // Teletransporte por obj_tp
            
                if (/*!datosIAMod.enemigo ||*/ !datosIAMod.agitando || PJInvi || obj_pj.muerto) {
                
                    // Cambio la dirección de la IA por la inversa del PJ
                
                    if (direccionPJ == datosIAMod.direccion) {
                        switch (direccionPJ) {
                            case 0:
                                datosIAMod.direccion = 1;
                                break;
                            case 1:
                                datosIAMod.direccion = 0;
                                break;
                            case 2:
                                datosIAMod.direccion = 3;
                                break;
                            case 3:
                                datosIAMod.direccion = 2;
                                break;
                        }
                    }
                
                    if (random(10) > 5) {
                    
                        // Hago movimientos random en el caso de que no sea enemigo, este invi o no esté agitando
                    
                        switch (datosIAMod.direccion) {
                            case 0:
                                datosIAMod.y += 2;
                                if (datosIAMod.y >= 2224) {
                                    datosIAMod.y = 2192;
                                }
                                break;
                            case 1:
                                datosIAMod.y -= 2;
                                if (datosIAMod.y < 144) {
                                    datosIAMod.y = 176;
                                }
                                break;
                            case 2:
                                datosIAMod.x -= 2;
                                if (datosIAMod.x < 320) {
                                    datosIAMod.x = 352;
                                }
                                break;
                            case 3:
                                datosIAMod.x += 2;
                                if (datosIAMod.x >= 2080) {
                                    datosIAMod.x = 2048;
                                }
                                break;
                        }
                        
                    }            
                
                    // direccionPJ = -1;
                    
                } else if (direccionPJ != -1 /*&& datosIAMod.enemigo*/ && datosIAMod.agitando && !PJInvi && !datosIAMod.inmovilizado && datosIAMod.sigueAlOtroMapa && !obj_pj.muerto) {
                
                    // Si es enemigo, agita, el PJ no esta invi y la IA no esta inmo...
                    
                    switch (direccionPJ) {
                        case 0:
                            if (datosIAMod.y < datosIAMod.tpCercaY) {
                                datosIAMod.y += 2;
                            }
                            break;
                        case 1:
                            if (datosIAMod.y > datosIAMod.tpCercaY) {
                                datosIAMod.y -= 2;
                            }
                            break;
                        case 2:
                            if (datosIAMod.x > datosIAMod.tpCercaX) {
                                datosIAMod.x -= 2;
                            }
                            break;
                        case 3:
                            if (datosIAMod.x < datosIAMod.tpCercaX) {
                                datosIAMod.x += 2;
                            }
                            break;
                    }
                    
                    if (datosIAMod.distTPCerca > 0) {
                        datosIAMod.distTPCerca -= 1.25;
                    } else {
                        crea = true;
                    }
                    
                    datosIAMod.direccion = direccionPJ;
                    
                    if (crea) {
                        datosIAMod.puedeCrear = true;
						globalIA[k] = datosIAMod;
                        crearIADelMundo();
                    }
                    
                } 
            
            }
            
        }
    
    }
	
	if (!crea)
		globalIA[k] = datosIAMod;

}
