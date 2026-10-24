//todos estos scripts dependen de las variables de obj_pj asi que por ahora solo deben llamarse desde ese objeto!

function scr_ataqueDistancia(){

}

function ataqueArco(_x, _y){
if (online_activo()) { online_atacar("bow", _x, _y); return; }

	if (flechaEnInv == -1 || !puedeAtacar) exit;
	var idINFO = 0;
                                        
	if (energia < 20) {
		var idINFO = instance_create_depth(x, y, 0, obj_INFO);
		idINFO.padre = id;
		idINFO.texto = "¡Energía menor a 20!";
		alarm[3] = 1;
		exit;
	}

	    if (obj_inventario.slots[flechaEnInv].cant > 0) {
                                    
	        if (invisible) invisible = false;
                                            
	        with (obj_persona) {
	            if (agitando) alarm[5] = 1;        
	        }
		}
                                    
	    energia -= 20;
                                    
	    if (position_meeting(_x, _y, obj_npc_basic)) {
                            
	        var idNPC = instance_position(_x, _y, obj_npc_basic);
                                            
	        if (idNPC.hostil) {
                                                
	            var valido = true;
                                                
	            if (idNPC.object_index == obj_persona) {
					valido = !idNPC.muerto;
	            }
                                                
	            if (valido && idNPC.object_index == obj_persona) {
                                
	                if (obj_mapas_mundo.mapas[room]) {
	                    valido = false;
	                    var idINFO = instance_create_depth(x, y, 0, obj_INFO);
	                    idINFO.texto = "¡No podés atacar en una zona segura!";
	                }
                                                    
					if (bloqueadoPorBandoArena(idNPC)) {
						valido = false;
					} else if (valido && !obj_pj.pk && !idNPC.pk) {
						if (obj_pj.esArmada) {
							valido = false;
							var idINFO = instance_create_depth(x, y, 0, obj_INFO);
							idINFO.texto = "No podés atacar ciudadanos siendo de la Armada Imperial";
						} else if (obj_seguro.activo) {
							valido = false;
							var idINFO = instance_create_depth(x, y, 0, obj_INFO);
							idINFO.texto = "Desactivá el seguro para atacar ciudadanos";
						} else {
							obj_pj.pk = true;

							if (salud > 0) {
							    obj_pj.puntosPK += round(random_range(5, 7));
							    idNPC.yaHablo = false;
							    idNPC.alarm[5] = 1;
							}
						}
					}

	            }
                                            
	            if (valido) {

	                var defendidoConEscudo = false;

	                frameArma = 0;
	                alarm[8] = 1;
	                puedeAtacar = false;
	                alarm[1] = 35;
                                                    
	                var acerto = true;
	                var chances = 0;
                                                    
	                if (skills[12] >= 0 && skills[12] <= 10) {
	                    chances = 4.85;
	                } else if (skills[12] >= 11 && skills[12] <= 20) {
	                    chances = 4.5;
	                }  else if (skills[12] >= 21 && skills[12] <= 30) {
	                    chances = 4.15;
	                }  else if (skills[12] >= 31 && skills[12] <= 40) {
	                    chances = 3.8;
	                }  else if (skills[12] >= 41 && skills[12] <= 50) {
	                    chances = 3.5;
	                }  else if (skills[12] >= 51 && skills[12] <= 60) {
	                    chances = 3.25;
	                }  else if (skills[12] >= 61 && skills[12] <= 70) {
	                    chances = 3;
	                }  else if (skills[12] >= 71 && skills[12] <= 80) {
	                    chances = 2.75;
	                }  else if (skills[12] >= 81 && skills[12] <= 90) {
	                    chances = 2.5;
	                }  else if (skills[12] >= 91 && skills[12] <= 100) {
	                    chances = 2.35;
	                }
                                                    
	                chances -= obtenerAtributoAgilidadPJ() / 18;
	                chances += idNPC.evasion * 0.0085;
	                chances = chances / obj_pj.modProbArco;
                                                    
	                if (random(10) < chances) {
	                    acerto = false;
	                } else {
	                    if (idNPC.object_index == obj_persona) {
	                        if (idNPC.eqEscudo != -1) {
	                            if (random(20) < chances) {
	                                acerto = false;
	                            }
	                        }
	                    }
	                }
                                                    
	                if (acerto) {
														
						if (obj_pj.flechaActual != 217) {
		                    if (skills[12] < skillsNaturales[nivel]) {
		                        intentarSubirSkillNatural(12, 0.35);
		                    }
						}
                                                    
	                    with (idNPC) {
															
							if (obj_pj.flechaActual != 217) {
															
								// Flechas comunes
															
		                        if (idNPC.object_index == obj_persona) {
		                            var dano = calcularDanoFisicoPJ(random_range(obj_pj.danoMin, obj_pj.danoMax), true);
		                        } else {
		                            var dano = calcularDanoFisicoPJ(random_range(obj_pj.danoMin, obj_pj.danoMax), false);
		                        }
		                        dano = floor(dano * obj_pj.modDanoLvl);                                            
                                                    
		                        if (dano < 1) {
		                            dano = 1;
		                        }
                                                    
		                        idDano = crearTextoDano(idNPC.x, idNPC.y, 0, -1);
                                                            
		                        var expOtorgada = 0;
                                                                
		                        if (idNPC.salud > 0) {
		                            expOtorgada = floor(idNPC.experiencia / (idNPC.salud / dano));
		                        }
                                                            
		                        if (idNPC.experiencia - expOtorgada <= 0) {
		                            expOtorgada = idNPC.experiencia;
		                            idNPC.experiencia = 0;
		                        } else {
		                            idNPC.experiencia -= expOtorgada;
		                        }
                                                            
		                        if (idNPC.object_index != obj_persona && (idNPC.domado || idNPC.invocado)) {
		                            expOtorgada = 0;
		                        }

	                            //multiplicador de experiencia
	                            expOtorgada = expOtorgada * obj_opciones.multiExp
                                                    
		                        idDano.padre = idNPC;
	                                                            
                                                    
		                        idDano.texto = string(dano);
		                        salud -= dano;
                                                            
		                        reproducirSonido(snd_flechaAcertada, false, false);
                                                            
		                        if (idNPC.object_index == obj_persona) {
		                            reproducirSonido(snd_golpeRecibido, false, false);
		                        } else {
		                            reproducirSonido(snd_golpeANPC, false, false);
		                        }
                                                            
		                        vibrarPantalla();
                                                            
		                        if (salud > 0 && object_index != obj_persona && domado) {
		                            for (var i = 0; i < 3; i++) {
		                                if (obj_pj.criaturasHijas[i, 0] == id) {
		                                    break;
		                                }
		                            }
		                            obj_pj.criaturasHijas[i, 2] = salud;
		                        }
                                                    
		                        if (object_index == obj_persona && !is_special_room()) {
		                            if (salud <= 0) {
		                                if (pk) {
		                                    other.criminalesMatados++;
		                                } else {
		                                    other.puntosPK = -1;
		                                    other.ciudadanosMatados++;
		                                }
		                            }
		                        }

		                        if (obj_pj.nivel < obj_pj.nivelMax) {
		                            if (obj_pj.experiencia < obj_pj.expLvl[obj_pj.nivel] - expOtorgada) {
		                                obj_pj.experiencia += expOtorgada;
		                            } else {
		                                subirNivel();
		                            }
		                        }
															
							} else {
															
								// Flechas Paralizantes
																
								if (object_index == obj_npc_dragonic) {
			                        var idINFO = instance_create_depth(obj_pj.x, obj_pj.y, 0, obj_INFO);
			                        idINFO.padre = obj_pj.id;
			                        idINFO.texto = "¡Esta criatura es inmune a la parálisis!";
									reproducirSonido(snd_fallo, false, false);
			                    } else {
																	
									if (obj_pj.skills[12] < obj_pj.skillsNaturales[obj_pj.nivel]) {
				                        intentarSubirSkillNatural(12, 0.35);
				                    }
																
			                        reproducirSonido(snd_flechaAcertada, false, false);
			                        vibrarPantalla();
																	
									if (obj_pj.invisible) {
			                            obj_pj.invisible = false;
                                                                
			                            with (obj_persona) {
			                                if (agitando) {
			                                    alarm[5] = 1;        
			                                }
			                            }
			                        }
																
			                        var idEfectoHechizo = instance_create_depth(x, y, 0, obj_paralizar);
			                        idEfectoHechizo.padre = id;
			                        reproducirSonido(snd_dardoMagico, false, false);
                                                            
			                        if (object_index != obj_persona) {
			                            paralizado = true;
			                            inmovilizado = false;
			                            alarm[4] = 7200; // 2 Minutos
			                        } else {
			                            alarm[7] = 170;
			                            inmovilizado = true;
			                            alarm[4] = 1800; // 30 Segundos
			                        }                                    
                                                            
			                        if (object_index == obj_persona) {
                                                                
			                            if (!obj_pj.pk) {
			                                if (!pk) {
			                                    obj_pj.pk = true;
			                                    if (salud > 0) {
			                                        obj_pj.puntosPK += round(random_range(5, 7));
			                                        yaHablo = false;
			                                        alarm[5] = 1;
			                                    }
			                                }
			                            }
			                            if (!pk && salud <= 0) {
			                                obj_pj.puntosPK = -1;
			                            }
			                        }
																
								}
															
							}
                                                            
	                    }
                                                        
	                } else {
                                                    
	                    if (defendidoConEscudo) {
	                        var idINFO = instance_create_depth(idNPC.x, idNPC.y, 0, obj_INFO);
	                        idINFO.padre = idNPC;
	                        idINFO.texto = "¡Defendido con escudo!";
	                        reproducirSonido(snd_defensaEscudo, false, false);
	                    } else {
	                        var idINFO = instance_create_depth(x, y, 0, obj_INFO);
	                        idINFO.padre = id;
	                        idINFO.texto = "¡Fallás!";
	                        reproducirSonido(snd_fallo, false, false);
	                    }
	                    idINFO.color = c_red;
                                                        
	                }
                                                
	            }
                                                
	        }
                                        
	    } else {
	        var idINFO = instance_create_depth(x, y, 0, obj_INFO);
	        idINFO.padre = id;
	        idINFO.color = make_color_rgb(211, 90, 211);
	        idINFO.texto = "¡Target inválido!"; 
	    }
		puedeAtacar = false;
	    alarm[3] = 1;
		alarm[1] = 35;
                                    
	    if (obj_inventario.slots[flechaEnInv].cant > 1) {
                                        
	        obj_inventario.slots[flechaEnInv].cant--;
                                            
	    } else if (obj_inventario.slots[flechaEnInv].cant > 0) {
	        obj_inventario.slots[flechaEnInv] = crearSlotInv(-1, 0, false);
                                        
	        atacaConArco = false;
	        flechaActual = -1;
	        flechaEnInv = -1;
                                            
	    }
}

function lanzarHechizo(_x, _y){
if (online_activo()) { online_atacar("cast", _x, _y); return; }
	if (obj_hechizos.seleccionado == -1|| !puedeAtacar) exit;
                        
	var lanzo = true;
                            
	for (var i = 0; i < obj_hechizos.maximoHechizos; i++) {
                                
	    if (obj_hechizos.hechizos[i].indice == obj_hechizos.seleccionado) {
                                        
	        var idINFO = 0;
	        var valido = true;
                                        
	        if (clase == 7) {
	            if (
	            obj_hechizos.hechizos[i].indice == 9 || 
	            obj_hechizos.hechizos[i].indice == 13 || 
	            obj_hechizos.hechizos[i].indice == 10 ||
	            obj_hechizos.hechizos[i].indice == 4 ||
	            obj_hechizos.hechizos[i].indice == 11 ||
	            obj_hechizos.hechizos[i].indice == 16
	            ) {
	                if (armaActual != 18 && armaActual != 19 && armaActual != 20) {
	                    valido = false;
	                    idINFO = instance_create_depth(x, y, 0, obj_INFO);
	                    idINFO.padre = id;
	                    idINFO.texto = "¡Necesitás un báculo para lanzar este hechizo!";
	                }
	            }
	        }
                                        
	        if (valido) {
	            if (obj_hechizos.hechizos[i].indice == 17 || obj_hechizos.hechizos[i].indice == 18 || obj_hechizos.hechizos[i].indice == 19) {
	                if (clase != 5) {
	                    valido = false;
	                    idINFO = instance_create_depth(x, y, 0, obj_INFO);
	                    idINFO.padre = id;
	                    idINFO.texto = "¡Este hechizo es solo para Druidas!";
	                } else if (obj_hechizos.hechizos[i].indice == 17 || obj_hechizos.hechizos[i].indice == 18) {
						if (armaActual != 227) {
		                    valido = false;
		                    idINFO = instance_create_depth(x, y, 0, obj_INFO);
		                    idINFO.padre = id;
		                    idINFO.texto = "¡Necesitás un báculo para lanzar este hechizo!";
		                }
					}
	            }
	        }
                                        
	        if (valido) {
	            if (clase == 7) {
	                if (
	                obj_hechizos.hechizos[i].indice == 4 ||
	                obj_hechizos.hechizos[i].indice == 9 ||
	                obj_hechizos.hechizos[i].indice == 10 ||
	                obj_hechizos.hechizos[i].indice == 11 ||
	                obj_hechizos.hechizos[i].indice == 13 ||
	                obj_hechizos.hechizos[i].indice == 16
	                ) {
	                    if (armaActual != 18 && armaActual != 19 && armaActual != 20) {
	                        valido = false;
	                        idINFO = instance_create_depth(x, y, 0, obj_INFO);
	                        idINFO.padre = id;
	                        idINFO.texto = "¡Necesitás un báculo para lanzar este hechizo!";
	                    }
	                }
	            }
	        }
                                    
	        if (valido) {
	            if (skills[0] < obj_hechizos.hechizos[i].skill) {
	                idINFO = instance_create_depth(x, y, 0, obj_INFO);
	                idINFO.padre = id;
	                idINFO.texto = "¡Magia menor a " + string(obj_hechizos.hechizos[i].skill) + "!";
	                valido = false;
	            } else if (mana < obj_hechizos.hechizos[i].mana) {
	                if (obj_hechizos.hechizos[i].tipo != "invocacion") {
	                    idINFO = instance_create_depth(x, y, 0, obj_INFO);
	                    idINFO.padre = id;
	                    idINFO.texto = "¡Maná menor a " + string(obj_hechizos.hechizos[i].mana) + "!";
	                    valido = false;
	                }
	            } else if (energia < obj_hechizos.hechizos[i].energia) {
	                idINFO = instance_create_depth(x, y, 0, obj_INFO);
	                idINFO.padre = id;
	                idINFO.texto = "¡Energía menor a " + string(obj_hechizos.hechizos[i].energia) + "!";
	                valido = false;
	            }
	        }
                                    
	        if (valido && (mana >= obj_hechizos.hechizos[i].mana || obj_hechizos.hechizos[i].tipo == "invocacion") && energia >= obj_hechizos.hechizos[i].energia && skills[0] >= obj_hechizos.hechizos[i].skill) {
                                                                    
	            if (obj_hechizos.hechizos[i].tipo == "negro") {
                                            
	                if (position_meeting(_x, _y, obj_npc_basic)) {
                            
	                    var idNPC = instance_position(_x, _y, obj_npc_basic);
                                                    
	                    if (idNPC.hostil) {
                                                
	                        var valido = true;
                                                
	                        if (idNPC.object_index == obj_persona) {
	                            if (idNPC.muerto) {
	                                valido = false;
	                            }
	                        }
                                                        
	                        if (valido && idNPC.object_index == obj_persona) {
                                                        
	                            if (obj_mapas_mundo.mapas[room]) {
	                                valido = false;
	                                var idINFO = instance_create_depth(x, y, 0, obj_INFO);
	                                idINFO.texto = "¡No podés atacar en una zona segura!";
	                            }
                                                    
	                            if (valido) {
                                                        
	                                if (bloqueadoPorBandoArena(idNPC)) {
	                                    valido = false;
	                                } else if (!obj_pj.pk && !idNPC.pk) {
	                                    if (obj_pj.esArmada) {
	                                        valido = false;
	                                        var idINFO = instance_create_depth(x, y, 0, obj_INFO);
	                                        idINFO.texto = "No podés atacar ciudadanos siendo de la Armada Imperial";
	                                    } else if (obj_seguro.activo) {
	                                        valido = false;
	                                        var idINFO = instance_create_depth(x, y, 0, obj_INFO);
	                                        idINFO.texto = "Desactivá el seguro para atacar ciudadanos";
	                                    }
	                                }
                                                            
	                            }
                                                            
	                        }
                                                    
	                        if (valido) {
                                                                                            
	                            if (obj_hechizos.hechizos[i].palabrasMagicas != "") {
	                                dicePalabrasMagicas = true;
	                                palabrasMagicas = obj_hechizos.hechizos[i].palabrasMagicas;
	                                alarm[6] = 180;
	                            }
                                                        
	                            if (invisible) {
	                                invisible = false;
                                                                
	                                with (obj_persona) {
	                                    if (agitando) {
	                                        alarm[5] = 1;        
	                                    }
	                                }
	                            }
                                                        
	                            if (skills[0] < skillsNaturales[nivel]) {
	                                intentarSubirSkillNatural(0, 0.35);
	                            }
                                                        
	                            puedeAtacar = false;
	                            alarm[1] = intervaloHechizo;
                                                            
	                            atacaConHechizo = true;
	                            energia -= obj_hechizos.hechizos[i].energia;
	                            mana -= obj_hechizos.hechizos[i].mana;
                                                            
	                            var idEfectoHechizo = 0;
                                                            
	                            switch (obj_hechizos.hechizos[i].indice) {
	                                case 5:
	                                    reproducirSonido(snd_dardoMagico, false, false);
	                                    idEfectoHechizo = instance_create_depth(idNPC.x, idNPC.y, 0, obj_dardo_magico);
	                                    break;
	                                case 6:
	                                    reproducirSonido(snd_dardoMagico, false, false);
	                                    idEfectoHechizo = instance_create_depth(idNPC.x, idNPC.y, 0, obj_flecha_magica);
	                                    break;
	                                case 7:
	                                    reproducirSonido(snd_dardoMagico, false, false);
	                                    idEfectoHechizo = instance_create_depth(idNPC.x, idNPC.y, 0, obj_flecha_electrica);
	                                    break;
	                                case 8:
	                                    reproducirSonido(snd_misilMagico, false, false);
	                                    idEfectoHechizo = instance_create_depth(idNPC.x, idNPC.y, 0, obj_misil_magico);
	                                    break;
	                                case 9:
	                                    reproducirSonido(snd_tormentaDeFuego, false, false);
	                                    idEfectoHechizo = instance_create_depth(idNPC.x, idNPC.y, 0, obj_tormenta_de_fuego);
	                                    break;
	                                case 10:
	                                    reproducirSonido(snd_descargaElectrica, false, false);
	                                    idEfectoHechizo = instance_create_depth(idNPC.x, idNPC.y, 0, obj_descarga_electrica);
	                                    break;
	                                case 11:
	                                    reproducirSonido(snd_apocalipsis, false, false);
	                                    idEfectoHechizo = instance_create_depth(idNPC.x, idNPC.y, 0, obj_apocalipsis);
	                                    break;
	                            }
                                                            
	                            idEfectoHechizo.padre = idNPC;
                                                            
	                            if (idNPC.object_index == obj_persona) {
	                                var dano = calcularDanoMagicoPJ(random_range(obj_hechizos.hechizos[i].efectoMin, obj_hechizos.hechizos[i].efectoMax), true, idNPC);
	                            } else {
	                                var dano = calcularDanoMagicoPJ(random_range(obj_hechizos.hechizos[i].efectoMin, obj_hechizos.hechizos[i].efectoMax), false, -1);
	                            }
                                                            
	                            idDano = crearTextoDano(idNPC.x, idNPC.y, 0, -1);
                                                            
	                            var expOtorgada = 0;
                                                            
	                            if (idNPC.salud > 0) {
	                                expOtorgada = floor(idNPC.experiencia / (idNPC.salud / dano));
	                            }
                                                
	                            if (idNPC.experiencia - expOtorgada <= 0) {
	                                expOtorgada = idNPC.experiencia;
	                                idNPC.experiencia = 0;
	                            } else {
	                                idNPC.experiencia -= expOtorgada;
	                            }
                                                            
	                            if (idNPC.object_index != obj_persona && (idNPC.domado || idNPC.invocado)) {
	                                expOtorgada = 0;
	                            }

	                            //multiplicador de experiencia
	                            expOtorgada = expOtorgada * obj_opciones.multiExp
                                                
	                            idDano.padre = idNPC;
                                                            
                                                
	                            idDano.texto = string(dano);
	                            idNPC.salud -= dano;
                                                            
	                            vibrarPantalla();
                                                            
	                            if (instance_exists(idNPC) && idNPC.salud > 0 && idNPC.object_index != obj_persona && idNPC.domado) {
	                                for (var i = 0; i < 3; i++) {
	                                    if (obj_pj.criaturasHijas[i, 0] == idNPC) {
	                                        break;
	                                    }
	                                }
	                                obj_pj.criaturasHijas[i, 2] = idNPC.salud;
	                            }
                                                
	                            if (idNPC.object_index == obj_persona) {
	                                if (!pk) {
	                                    if (!idNPC.pk) {
	                                        pk = true;
	                                        if (idNPC.salud > 0) {
	                                            puntosPK += round(random_range(5, 7));
	                                            idNPC.yaHablo = false;
	                                            idNPC.alarm[5] = 1;
	                                        }
	                                    }
	                                }
	                                if (idNPC.salud <= 0  && !is_special_room()) {
	                                    if (idNPC.pk) {
	                                        criminalesMatados++;
	                                    } else {
	                                        puntosPK = -1;
	                                        ciudadanosMatados++;
	                                    }
	                                }
	                            }

	                            if (obj_pj.nivel < obj_pj.nivelMax) {
	                                if (obj_pj.experiencia < obj_pj.expLvl[obj_pj.nivel] - expOtorgada) {
	                                    obj_pj.experiencia += expOtorgada;
	                                } else {
	                                    subirNivel();
	                                }
	                            }
                                                            
	                        }
                                                        
	                    }
                                                
	                } else {
	                    if (position_meeting(_x, _y , obj_area_flechas)) {
	                        lanzo = false;
	                    } else {
	                        var idINFO = instance_create_depth(x, y, 0, obj_INFO);
	                        idINFO.padre = id;
	                        idINFO.color = make_color_rgb(211, 90, 211);
	                        idINFO.texto = "¡Target inválido!"; 
	                    }
	                }
                                            
	            } else if (obj_hechizos.hechizos[i].tipo == "curacion") {
                                            
	                if (position_meeting(_x, _y , self)) {
                                                
	                    if (obj_hechizos.hechizos[i].palabrasMagicas != "") {
	                        dicePalabrasMagicas = true;
	                        palabrasMagicas = obj_hechizos.hechizos[i].palabrasMagicas;
	                        alarm[6] = 180;
	                    }
                                                    
	                    if (invisible) {
	                        invisible = false;
                                                        
	                        with (obj_persona) {
	                            if (agitando) {
	                                alarm[5] = 1;        
	                            }
	                        }
	                    }
                                            
	                    if (skills[0] < skillsNaturales[nivel]) {
	                        intentarSubirSkillNatural(0, 0.35);
	                    }
                                                
	                    puedeAtacar = false;
	                    alarm[1] = intervaloHechizo;
                                                    
	                    atacaConHechizo = true;
	                    energia -= obj_hechizos.hechizos[i].energia;
	                    mana -= obj_hechizos.hechizos[i].mana;
                                                    
	                    var idEfectoHechizo = 0;
                                                    
	                    switch (obj_hechizos.hechizos[i].indice) {
	                        case 1:
	                            reproducirSonido(snd_curarHeridasLeves, false, false);
	                            idEfectoHechizo = instance_create_depth(x, y, 0, obj_curar_heridas_leves);
	                            break;
	                        case 2:
	                            reproducirSonido(snd_curarHeridasGraves, false, false);
	                            idEfectoHechizo = instance_create_depth(x, y, 0, obj_curar_heridas_graves);
	                            break;
	                    }
                                                    
	                    idEfectoHechizo.padre = id;
                                                    
	                    var cura = calcularDanoMagicoPJ(random_range(obj_hechizos.hechizos[i].efectoMin, obj_hechizos.hechizos[i].efectoMax), false, -1);
	                    idCura = crearTextoDano(x, y - 40, cura, id);
                                        
                                                    
	                    idCura.color = c_white;
                                                    
	                    if (salud <= saludMax - cura) {
	                        salud += cura;
	                    } else {
	                        salud = saludMax;
	                    }
                                                
	                } else {
                                                     
	                    if (position_meeting(_x, _y , obj_area_flechas)) {
	                        lanzo = false;
	                    } else {
	                        var idINFO = instance_create_depth(x, y, 0, obj_INFO);
	                        idINFO.padre = id;
	                        idINFO.color = make_color_rgb(211, 90, 211);
	                        idINFO.texto = "¡Target inválido!"; 
	                    }
                                                    
	                }
                                            
	            } else if (obj_hechizos.hechizos[i].tipo == "paralisis") {
                                        
	                if (position_meeting(_x, _y , obj_npc_basic)) {
                            
	                    var idNPC = instance_position(_x, _y , obj_npc_basic);
                                                    
	                    if (idNPC.hostil) {
                                                    
	                        var valido = true;
                                                        
	                        if (idNPC.object_index == obj_persona) {
	                            if (idNPC.muerto) {
	                                valido = false;
	                            }
	                        }
                                                
	                        if (valido && idNPC.object_index == obj_persona) {
                                                        
	                            if (obj_mapas_mundo.mapas[room]) {
	                                valido = false;
	                                var idINFO = instance_create_depth(x, y, 0, obj_INFO);
	                                idINFO.texto = "¡No podés atacar en una zona segura!";
	                            }
                                                            
	                            if (valido) {
                                                        
	                                if (bloqueadoPorBandoArena(idNPC)) {
	                                    valido = false;
	                                } else if (!obj_pj.pk && !idNPC.pk) {
	                                    if (obj_pj.esArmada) {
	                                        valido = false;
	                                        var idINFO = instance_create_depth(x, y, 0, obj_INFO);
	                                        idINFO.texto = "No podés atacar ciudadanos siendo de la Armada Imperial";
	                                    } else if (obj_seguro.activo) {
	                                        valido = false;
	                                        var idINFO = instance_create_depth(x, y, 0, obj_INFO);
	                                        idINFO.texto = "Desactivá el seguro para atacar ciudadanos";
	                                    }
	                                }
                                                            
	                            }
                                                            
	                        }
                                                        
	                        if (idNPC.object_index == obj_npc_dragonic) {
	                            var idINFO = instance_create_depth(x, y, 0, obj_INFO);
	                            idINFO.padre = id;
	                            idINFO.texto = "¡Esta criatura es inmune a este hechizo!";
	                            valido = false;
	                        }
                                                        
	                        if (valido) {
                                                        
	                            if (obj_hechizos.hechizos[i].palabrasMagicas != "") {
	                                dicePalabrasMagicas = true;
	                                palabrasMagicas = obj_hechizos.hechizos[i].palabrasMagicas;
	                                alarm[6] = 180;
	                            }
                                                        
	                            if (invisible) {
	                                invisible = false;
                                                                
	                                with (obj_persona) {
	                                    if (agitando) {
	                                        alarm[5] = 1;        
	                                    }
	                                }
	                            }
                                                        
	                            if (skills[0] < skillsNaturales[nivel]) {
	                                intentarSubirSkillNatural(0, 0.35);
	                            }
                                                        
	                            puedeAtacar = false;
	                            alarm[1] = intervaloHechizo;
                                                            
	                            atacaConHechizo = true;
	                            energia -= obj_hechizos.hechizos[i].energia;
	                            mana -= obj_hechizos.hechizos[i].mana;
                                                            
	                            var idEfectoHechizo = 0;
                                                            
	                            switch (obj_hechizos.hechizos[i].indice) {
	                                case 12:
	                                    reproducirSonido(snd_dardoMagico, false, false);
	                                    idEfectoHechizo = instance_create_depth(idNPC.x, idNPC.y, 0, obj_paralizar);
	                                    break;
	                                case 13:
	                                    reproducirSonido(snd_inmovilizar, false, false);
	                                    idEfectoHechizo = instance_create_depth(idNPC.x, idNPC.y, 0, obj_inmovilizar);
	                                    break;
	                            }
                                                            
	                            idEfectoHechizo.padre = idNPC;
                                                            
	                            if (idNPC.object_index != obj_persona) {
	                                idNPC.inicioParalisis = current_time
	                                if (obj_hechizos.hechizos[i].indice == 12) {
	                                    idNPC.paralizado = true;
	                                    idNPC.inmovilizado = false;
	                                    idNPC.alarm[4] = 7200; // 2 Minutos
	                                } else {
	                                    idNPC.inmovilizado = true;
	                                    idNPC.paralizado = false;
	                                    idNPC.alarm[4] = 7200; // 2 Minutos
	                                }
	                                idNPC.duracionParalisis =  120
	                            } else {
	                                idNPC.alarm[7] = 170;
	                                idNPC.inmovilizado = true;
	                                idNPC.alarm[4] = 1800; // 30 Segundos
	                                idNPC.duracionParalisis = 30
	                            }                                    
                                                            
	                            if (idNPC.object_index == obj_persona) {
                                                                
	                                if (!pk) {
	                                    if (!idNPC.pk) {
	                                        pk = true;
	                                        if (idNPC.salud > 0) {
	                                            puntosPK += round(random_range(5, 7));
	                                            idNPC.yaHablo = false;
	                                            idNPC.alarm[5] = 1;
	                                        }
	                                    }
	                                }
	                                if (!idNPC.pk && idNPC.salud <= 0) {
	                                    puntosPK = -1;
	                                }
	                            }
                                                        
	                        }
                                                        
	                    }
                                                
	                } else {
	                    if (position_meeting(_x, _y , obj_area_flechas)) {
	                        lanzo = false;
	                    } else {
	                        var idINFO = instance_create_depth(x, y, 0, obj_INFO);
	                        idINFO.padre = id;
	                        idINFO.color = make_color_rgb(211, 90, 211);
	                        idINFO.texto = "¡Target inválido!"; 
	                    }
	                }
                                                
	            } else if (obj_hechizos.hechizos[i].tipo == "invisibilidad") {
                                            
	                if (position_meeting(_x, _y , self)) {
                                                
	                    dicePalabrasMagicas = false;
	                    palabrasMagicas = "";
                                                
	                    if (skills[0] < skillsNaturales[nivel]) {
	                        intentarSubirSkillNatural(0, 0.35);
	                    }
                                                
	                    puedeAtacar = false;
	                    alarm[1] = intervaloHechizo;
                                                    
	                    atacaConHechizo = true;
	                    energia -= obj_hechizos.hechizos[i].energia;
	                    mana -= obj_hechizos.hechizos[i].mana;
                                                    
	                    reproducirSonido(snd_dardoMagico, false, false);
													
						var idEfectoHechizo = instance_create_depth(x, y, 0, obj_invisibilidad);
						idEfectoHechizo.padre = id;
                                                    
	                    obj_pj.invisible = true;
	                    obj_pj.alarm[5] = 1800;
                                                    
	                    if (instance_number(obj_persona) > 0) {
	                        with (obj_persona) {
	                            yaHablo = false;
	                        }
	                    }
                                                
	                } else {
	                    if (position_meeting(_x, _y , obj_area_flechas)) {
	                        lanzo = false;
	                    } else {
	                        var idINFO = instance_create_depth(x, y, 0, obj_INFO);
	                        idINFO.padre = id;
	                        idINFO.color = make_color_rgb(211, 90, 211);
	                        idINFO.texto = "¡Target inválido!"; 
	                    }
	                }
                                                
	            } else if (obj_hechizos.hechizos[i].tipo == "curar veneno") {
                                            
	                if (position_meeting(_x, _y , self)) {
                                                
	                    if (obj_hechizos.hechizos[i].palabrasMagicas != "") {
	                        dicePalabrasMagicas = true;
	                        palabrasMagicas = obj_hechizos.hechizos[i].palabrasMagicas;
	                        alarm[6] = 180;
	                    }
                                                    
	                    if (invisible) {
	                        invisible = false;
                                                        
	                        with (obj_persona) {
	                            if (agitando) {
	                                alarm[5] = 1;        
	                            }
	                        }
	                    }
                                            
	                    if (skills[0] < skillsNaturales[nivel]) {
	                        intentarSubirSkillNatural(0, 0.35);
	                    }
                                                
	                    puedeAtacar = false;
	                    alarm[1] = intervaloHechizo;
                                                    
	                    atacaConHechizo = true;
	                    energia -= obj_hechizos.hechizos[i].energia;
	                    mana -= obj_hechizos.hechizos[i].mana;
                                                    
	                    var idEfectoHechizo = instance_create_depth(x, y, 0, obj_curar_veneno);
	                    idEfectoHechizo.padre = id;
                                                    
	                    reproducirSonido(snd_dardoMagico, false, false);
                                                    
	                    envenenado = false;
	                    veneno = 0;
                                                
	                } else {
	                    if (position_meeting(_x, _y , obj_area_flechas)) {
	                        lanzo = false;
	                    } else {
	                        var idINFO = instance_create_depth(x, y, 0, obj_INFO);
	                        idINFO.padre = id;
	                        idINFO.color = make_color_rgb(211, 90, 211);
	                        idINFO.texto = "¡Target inválido!"; 
	                    }
	                }
                                            
	            } else if (obj_hechizos.hechizos[i].tipo == "remover") {
                                            
	                if (inmovilizado) {
	                    if (position_meeting(_x, _y , self)) {
                                                    
	                        if (obj_hechizos.hechizos[i].palabrasMagicas != "") {
	                            dicePalabrasMagicas = true;
	                            palabrasMagicas = obj_hechizos.hechizos[i].palabrasMagicas;
	                            alarm[6] = 180;
	                        }
                                                        
	                        if (invisible) {
	                            invisible = false;
                                                            
	                            with (obj_persona) {
	                                if (agitando) {
	                                    alarm[5] = 1;        
	                                }
	                            }
	                        }
                                                
	                        if (skills[0] < skillsNaturales[nivel]) {
	                            intentarSubirSkillNatural(0, 0.35);
	                        }
                                                    
	                        puedeAtacar = false;
	                        alarm[1] = intervaloHechizo;
                                                        
	                        atacaConHechizo = true;
	                        energia -= obj_hechizos.hechizos[i].energia;
	                        mana -= obj_hechizos.hechizos[i].mana;
                                                        
	                        reproducirSonido(snd_dardoMagico, false, false);
                                                        
	                        inmovilizado = false;
                                                    
	                    } else {
	                        if (position_meeting(_x, _y , obj_area_flechas)) {
	                            lanzo = false;
	                        } else {
	                            var idINFO = instance_create_depth(x, y, 0, obj_INFO);
	                            idINFO.padre = id;
	                            idINFO.color = make_color_rgb(211, 90, 211);
	                            idINFO.texto = "¡Target inválido!"; 
	                        }
	                    }
	                } else {
	                    if (position_meeting(_x, _y , self)) {
	                        var idINFO = instance_create_depth(x, y, 0, obj_INFO);
	                        idINFO.padre = id;
	                        idINFO.texto = "¡No estás inmovilizado ni paralizado!"; 
	                    }
	                }
                                            
	            } else if (obj_hechizos.hechizos[i].tipo == "invocacion") {
                                                
	                if (obj_pj.puedeMoverse) {
	                    if (obj_hechizos.hechizos[i].indice == 19) {
                                                    
	                        // Invocar mascotas
                                                    
	                        var validoInvocar = false;
                                                    
	                        for (var j = 0; j < 3; j++) {
	                            if (criaturasHijas[j, 1] != -1) {
	                                validoInvocar = true;
	                                break;    
	                            }
	                        }
                                                    
	                        if (validoInvocar) {
                                                        
	                            if (!position_meeting(_x, _y , obj_area_flechas)) {
                                                            
	                                var res = invocarGuardarMascotas(_x, _y);
                                                                            
	                                if (res == 1) { // Tiene maná e invocó en tierra
                                                                
	                                    reproducirSonido(snd_logueo, false, false);
                                                                
	                                    dicePalabrasMagicas = true;
	                                    palabrasMagicas = obj_hechizos.hechizos[i].palabrasMagicas;
	                                    alarm[6] = 180;
                                                                
	                                        if (invisible) {
	                                        invisible = false;
                                                                        
	                                        with (obj_persona) {
	                                            if (agitando) {
	                                                alarm[5] = 1;        
	                                            }
	                                        }
	                                    }
                                                            
	                                    if (skills[0] < skillsNaturales[nivel]) {
	                                        intentarSubirSkillNatural(0, 0.35);
	                                    }
                                                                
	                                    puedeAtacar = false;
	                                    alarm[1] = intervaloHechizo;
                                                                    
	                                    atacaConHechizo = true;
	                                    energia -= obj_hechizos.hechizos[i].energia;
                                                                
	                                }
                                                        
	                            } else {
	                                lanzo = false;
	                            }     
                                                            
	                        } else {
	                            var idINFO = instance_create_depth(x, y, 0, obj_INFO);
	                            idINFO.padre = id;
	                            idINFO.texto = "¡No domaste ninguna criatura!";
	                        }  
                                                    
	                    } else {
                                                                
	                        if (!position_meeting(_x, _y , obj_area_flechas)) {
                                                    
	                            if (obj_hechizos.hechizos[i].indice == 14) {
	                                // Llamado a la Naturaleza
	                                var res = invocarCriatura(obj_hechizos.hechizos[i].mana, obj_npc_lobo_invocado, 3, _x, _y);
	                            } else if (obj_hechizos.hechizos[i].indice == 15) {
	                                // Invocar Zombies
	                                var res = invocarCriatura(obj_hechizos.hechizos[i].mana, obj_npc_zombie_invocado, 3, _x, _y);
	                            } else if (obj_hechizos.hechizos[i].indice == 16) {
	                                // Invocar Elemental de Agua
	                                var res = invocarCriatura(obj_hechizos.hechizos[i].mana, obj_npc_ele_agua_invocado, 1, _x, _y);
	                            } else if (obj_hechizos.hechizos[i].indice == 17) {
	                                // Invocar Elemental de Tierra
	                                var res = invocarCriatura(obj_hechizos.hechizos[i].mana, obj_npc_ele_tierra_invocado, 1, _x, _y);
	                            } else if (obj_hechizos.hechizos[i].indice == 18) {
	                                // Invocar Elemental de Fuego
	                                var res = invocarCriatura(obj_hechizos.hechizos[i].mana, obj_npc_ele_fuego_invocado, 1, _x, _y);
	                            }
                                                            
	                            if (res) { // Tiene maná e invocó en tierra
                                                                                  
	                                reproducirSonido(snd_logueo, false, false);
                                                                                         
	                                dicePalabrasMagicas = true;
	                                palabrasMagicas = obj_hechizos.hechizos[i].palabrasMagicas;
	                                alarm[6] = 180;
                                                            
	                                    if (invisible) {
	                                    invisible = false;
                                                                    
	                                    with (obj_persona) {
	                                        if (agitando) {
	                                            alarm[5] = 1;        
	                                        }
	                                    }
	                                }
                                                        
	                                if (skills[0] < skillsNaturales[nivel]) {
	                                    intentarSubirSkillNatural(0, 0.35);
	                                }
                                                            
	                                puedeAtacar = false;
	                                alarm[1] = intervaloHechizo;
                                                                
	                                atacaConHechizo = true;
	                                energia -= obj_hechizos.hechizos[i].energia;
                                                                
	                            }
                                                        
	                        } else {
	                            lanzo = false;
	                        }
                                                        
	                    }
                                                    
	                } else {
	                    var idINFO = instance_create_depth(x, y, 0, obj_INFO);
	                    idINFO.padre = id;
	                    idINFO.texto = "¡No podés invocar criaturas en movimiento!";
	                }
	            }
                                        
	        }
                                        
	        break;
                                        
	    }
                                    
	}
                            
	if (lanzo) {
	    alarm[3] = 1;
	}
}