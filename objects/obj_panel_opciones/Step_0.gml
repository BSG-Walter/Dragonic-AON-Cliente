/// @description  Control general / control mouse

x = global.render_x + get_render_width() - 26;
y = global.render_y + 36;

if (visible) {

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
                
                if (device_mouse_y(device) <= y - 32 + 16) {
                    if (obj_opciones.opcionArboles) {
                        obj_opciones.opcionArboles = false;
                        with (obj_arbol_basic) {
                            image_alpha = 1;
                        }
                    } else {
                        obj_opciones.opcionArboles = true;
                    }
                } else if (device_mouse_y(device) <= y - 32 + 32) {
                    if (obj_opciones.opcionTechos) {
                        obj_opciones.opcionTechos = false;
                        with (obj_techo_basic) {
                            visible = true;
                            image_alpha = 1;
                        }
                    } else {
                        obj_opciones.opcionTechos = true;
                        with (obj_techo_basic) {
                            visible = true;
                            image_alpha = 1;
                        }
                    }
                } else if (device_mouse_y(device) <= y - 32 + 48) {
                    if (obj_opciones.opcionVibracion) {
                        obj_opciones.opcionVibracion = false;
                    } else {
                        obj_opciones.opcionVibracion = true;
                    }
                } else if (device_mouse_y(device) <= y - 32 + 64) {
                    if (obj_opciones.opcionAnimacionAgua) {
                        obj_opciones.opcionAnimacionAgua = false;
                        var lay = layer_get_id("Background_Agua");
                        if (lay != -1) {
                            var bg = layer_background_get_id(lay);
                            if (bg != -1) layer_background_sprite(bg, bck_agua_1);
                            layer_hspeed(lay, 0);
                            layer_vspeed(lay, 0);
                        }
                        with (obj_pez) {
                            instance_destroy();
                        }
                    } else {
                        obj_opciones.opcionAnimacionAgua = true;
                        var lay = layer_get_id("Background_Agua");
                        if (lay != -1) {
                            var bg = layer_background_get_id(lay);
                            if (bg != -1) layer_background_sprite(bg, bck_agua_2);
                        }
                        if (instance_exists(obj_control_animacion_agua))
                            obj_control_animacion_agua.alarm[0] = 300;
                        if (obj_opciones.opcionPeces) {
                            with (obj_pez) {
                                instance_destroy();
                            }
                            repeat(5) {
                                instance_create_depth(global.render_x + random(get_render_width()), global.render_y + random(get_render_height()), 0, obj_pez);
                            }
                        }
                    }
                } else if (device_mouse_y(device) <= y - 32 + 80) {
                    if (obj_opciones.opcionParticulas) {
                        obj_opciones.opcionParticulas = false;
                        with (obj_particula) {
                            instance_destroy();
                        }
                        with (obj_lluvia) {
                            instance_destroy();
                        }
                        with (obj_salpicadura) {
                            instance_destroy();
                        }
						if (obj_opciones.sonidoLluvia != -1)	
							audio_sound_gain(obj_opciones.sonidoLluvia, 0, 0)
                    } else {
                        obj_opciones.opcionParticulas = true;
                        with (obj_particula) {
                            instance_destroy();
                        }
                        with (obj_lluvia) {
                            instance_destroy();
                        }
                        with (obj_salpicadura) {
                            instance_destroy();
                        }
                        repeat(25) {
                            instance_create_depth(global.render_x + random(get_render_width()), global.render_y + random(get_render_height()), 0, obj_particula);
                        }
                        if (obj_opciones.lloviendo) { 
							crearLluvia(75, 0, 0);
							with (obj_pj) {
								obj_opciones.sonidoLluvia = reproducirSonido(snd_lluvia, true, false);	
								if (obj_opciones.sonidoLluvia != -1) {
									audio_sound_gain(obj_opciones.sonidoLluvia, 0, 0);
									audio_sound_gain(obj_opciones.sonidoLluvia, 1, 4000);
								}
							}
						}
                    }
                } else if (device_mouse_y(device) <= y - 32 + 96) {
                    if (obj_opciones.opcionNubes) {
                        obj_opciones.opcionNubes = false;
                        with (obj_nubes) {
                            instance_destroy();
                        }
                    } else {
                        obj_opciones.opcionNubes = true;
                        with (obj_nubes) {
                            instance_destroy();
                        }
                        instance_create_depth(0, 0, 0, obj_nubes);
                    }
                } else if (device_mouse_y(device) <= y - 32 + 112) {
                    if (obj_opciones.opcionPeces) {
                        obj_opciones.opcionPeces = false;
                        with (obj_pez) {
                            instance_destroy();
                        }
                    } else {
                        obj_opciones.opcionPeces = true;
                        if (obj_opciones.opcionAnimacionAgua) {
                            with (obj_pez) {
                                instance_destroy();
                            }
                            repeat(5) {
                                instance_create_depth(global.render_x + random(get_render_width()), global.render_y + random(get_render_height()), 0, obj_pez);
                            }
                        }
                    }
                } else if (device_mouse_y(device) <= y - 32 + 128) {
                    if (obj_opciones.opcionOptimizarCiudades) {
                        obj_opciones.opcionOptimizarCiudades = false;
                    } else {
                        obj_opciones.opcionOptimizarCiudades = true;
                    }
                    if (obj_mapas_mundo.mapas[room]) {
                        // Si es zona segura (ciudad)
                        var idINFO = instance_create_depth(obj_pj.x, obj_pj.y, 0, obj_INFO);
                        idINFO.padre = obj_pj.id;
                        idINFO.texto = "Volvé a entrar al mapa para ver los cambios";                        
                    }
                } else if (device_mouse_y(device) <= y - 32 + 144) {
                    if (obj_opciones.opcionInsigniaPionero) {
                        obj_opciones.opcionInsigniaPionero = false;
                    } else {
                        obj_opciones.opcionInsigniaPionero = true;
                    }
                }                
                
                // Guardo los datos
                
                ini_open("opciones.ini");
                write("opcionesFX", "opcionTechos", obj_opciones.opcionTechos);
                write("opcionesFX", "opcionArboles", obj_opciones.opcionArboles);
                write("opcionesFX", "opcionVibracion", obj_opciones.opcionVibracion);
                write("opcionesFX", "opcionAnimacionAgua", obj_opciones.opcionAnimacionAgua);
                write("opcionesFX", "opcionParticulas", obj_opciones.opcionParticulas);
                write("opcionesFX", "opcionNubes", obj_opciones.opcionNubes);
                write("opcionesFX", "opcionPeces", obj_opciones.opcionPeces);
                write("opcionesFX", "opcionOptimizarCiudades", obj_opciones.opcionOptimizarCiudades);
                write("opcionesFX", "opcionInsigniaPionero", obj_opciones.opcionInsigniaPionero);
                ini_close();
                
                obj_control_devices.devicesL[device] = false;
                
            }
            
        }
    
    }

}

