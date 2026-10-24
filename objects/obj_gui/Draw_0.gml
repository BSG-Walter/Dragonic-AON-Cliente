/// @description  Dibujo la interfaz

//Fondo de la interfaz inferior
draw_sprite(tl_interfaz,0,global.inventario_x, global.inventario_y)

//Oro
draw_sprite(spr_boton_oro, 0, global.inventario_x +11, global.inventario_y + 56);

/// Dibujo datos PJ
draw_set_font(fnt_Vedrana_7_bold);

draw_sprite(spr_vista_previa_PJ, 0, global.render_x, global.render_y);
draw_sprite(obj_pj.sprCabeza, 0, global.render_x+ 18, global.render_y + 18);
draw_set_color(c_silver);
draw_set_halign(fa_center);
draw_text(global.render_x+ 34, global.render_y + 4, string(obj_pj.nivel));
draw_text(global.render_x+ 27, global.render_y + 18, "XP: " + string(floor(obj_pj.experiencia / obj_pj.expLvl[obj_pj.nivel] * 100)) + "%");
draw_set_halign(fa_left);
// Pausa

draw_sprite(spr_pausa, 0, global.render_x+ render_width * 0.5, global.render_y);

// Ayuda

draw_sprite(spr_ayuda, obj_ayuda.image_index, global.render_x+ render_width - 2, global.render_y + 2);

// Opciones

draw_sprite(spr_opciones, 0, global.render_x+ render_width - 2, global.render_y + 26);

// Añadir bot
if (room == rm_arena) {
    with (obj_agregar_bot) {
        var draw_x = global.render_x + other.render_width - 2;
        var draw_y = global.render_y + 50;
        
        draw_sprite_ext(spr_agregar_bot, 0, draw_x, draw_y, escala, escala, 0, c_white, 1);
        draw_sprite_ext(spr_agregar_bot, 1, draw_x, draw_y + espacio_vertical, escala, escala, 0, c_white, 1);
    }
}

if (obj_configuracion.mostrado) {

    draw_sprite(spr_panel_opciones, 0, global.render_x+ render_width - 26, global.render_y + 36);
    
    if (obj_opciones.opcionArboles) {
        draw_sprite(spr_tick, 0, global.render_x+ render_width - 119, global.render_y + 11);
    }
    
    if (obj_opciones.opcionTechos) {
        draw_sprite(spr_tick, 0, global.render_x+ render_width - 119, global.render_y + 27);
    }
    
    if (obj_opciones.opcionVibracion) {
        draw_sprite(spr_tick, 0, global.render_x+ render_width - 119, global.render_y + 43);
    }
    
    if (obj_opciones.opcionAnimacionAgua) {
        draw_sprite(spr_tick, 0, global.render_x+ render_width - 119, global.render_y + 59);
    }
    
    if (obj_opciones.opcionParticulas) {
        draw_sprite(spr_tick, 0, global.render_x+ render_width - 119, global.render_y + 75);
    }
    
    if (obj_opciones.opcionNubes) {
        draw_sprite(spr_tick, 0, global.render_x+ render_width - 119, global.render_y + 91);
    }
    
    if (obj_opciones.opcionPeces) {
        draw_sprite(spr_tick, 0, global.render_x+ render_width - 119, global.render_y + 107);
    }
    
    if (obj_opciones.opcionOptimizarCiudades) {
        draw_sprite(spr_tick, 0, global.render_x+ render_width - 119, global.render_y + 123);
    }
    
    if (obj_opciones.opcionInsigniaPionero) {
        draw_sprite(spr_tick, 0, global.render_x+ render_width - 119, global.render_y + 139);
    }
    
}

// Seguro

draw_sprite(spr_seguro, obj_seguro.activo, global.render_x+ render_width, global.render_y + render_height);

// Retícula stick derecho (se dibuja en la GUI para que nada del mundo la tape)
if (obj_pj.aimActive && !obj_pj.muerto) {
    var _retX = obj_pj.aimX;
    var _retY = obj_pj.aimY;
    draw_sprite(spr_aim, 0, _retX, _retY);
    draw_set_alpha(0.85);
    var _tgt = noone;
    if (online_activo()) {
        var _targetId = online_objetivo(_retX, _retY, false, true);
        if (_targetId != "") _tgt = online_entidad(_targetId);
    } else {
        _tgt = instance_position(_retX, _retY, obj_npc_basic);
        if (_tgt != noone && !_tgt.hostil) _tgt = noone;
    }
    if (instance_exists(_tgt)) {
        draw_set_color(c_yellow);
        draw_circle(_tgt.x, _tgt.y - HALF_TILE, AIM_TARGET_RING_RADIUS, true);
        draw_circle(_tgt.x, _tgt.y - HALF_TILE, AIM_TARGET_RING_RADIUS + AIM_TARGET_RING_GAP, true);
    }
    draw_set_alpha(1);
    draw_set_color(c_white);
}

// Panel items

if (obj_panel_items.mostrado) {
    
    draw_set_alpha(0.85);
    draw_sprite(spr_panel_items, obj_panel_items.image_index, global.render_x+ render_width * 0.5, global.render_y + render_height * 0.5);
    
    draw_set_color(c_white);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_font(fnt_Vedrana_5_bold);
    draw_text(global.render_x+ render_width * 0.5 - 144 + 143, global.render_y + render_height * 0.5 - 113 + 217, obj_panel_items.campoCantidadS);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    
    var modPanelItemsX = 144;
    var modPanelItemsY = 113;
    draw_set_font(fnt_Vedrana_5_bold);
    
    // Ícono y datos
    
    var indicePanel = obj_panel_items.indiceItem;
    
    if (indicePanel != -1) {
    
        if (obj_panel_items.sectorPj) {
    
            var indiceInv = obj_inventario.slots[indicePanel].indice;
            if (indiceInv != -1) {
                draw_set_alpha(1);
                draw_set_color(c_white);
                if (!obj_panel_items.modoBanco) {
                    draw_text(global.render_x+ render_width * 0.5 - modPanelItemsX + 47, global.render_y + render_height * 0.5 - modPanelItemsY + 12, "Precio: " + string(obj_panel_items.precioItem));
                } else {
                    draw_text(global.render_x+ render_width * 0.5 - modPanelItemsX + 47, global.render_y + render_height * 0.5 - modPanelItemsY + 12, "Cantidad: " + string(obj_inventario.slots[indicePanel].cant)); 
                }
                draw_text(global.render_x+ render_width * 0.5 - modPanelItemsX + 47, global.render_y + render_height * 0.5 - modPanelItemsY + 20, string(obj_panel_items.validoItem));
                draw_text(global.render_x+ render_width * 0.5 - modPanelItemsX + 47, global.render_y + render_height * 0.5 - modPanelItemsY + 28, obj_panel_items.descItem);
                draw_sprite(spr_items, indiceInv, global.render_x+ render_width * 0.5 - modPanelItemsX + 8 + 16, global.render_y + render_height * 0.5 - modPanelItemsY + 9 + 32);
                draw_set_alpha(0.85);
            }
        
        } else if (obj_panel_items.sectorNpc) {
        
            var indiceInv = obj_panel_items.idPadre.slots[indicePanel].indice;
            if (indiceInv != -1) {
                draw_set_alpha(1);
                draw_set_color(c_white);
                if (!obj_panel_items.modoBanco) {
                    draw_text(global.render_x+ render_width * 0.5 - modPanelItemsX + 47, global.render_y + render_height * 0.5 - modPanelItemsY + 12, "Precio: " + string(obj_panel_items.precioItem));
                } else {
                    draw_text(global.render_x+ render_width * 0.5 - modPanelItemsX + 47, global.render_y + render_height * 0.5 - modPanelItemsY + 12, "Cantidad: " + string(obj_panel_items.idPadre.slots[indicePanel].cant));
                }
                draw_text(global.render_x+ render_width * 0.5 - modPanelItemsX + 47, global.render_y + render_height * 0.5 - modPanelItemsY + 20, string(obj_panel_items.validoItem));
                draw_text(global.render_x+ render_width * 0.5 - modPanelItemsX + 47, global.render_y + render_height * 0.5 - modPanelItemsY + 28, obj_panel_items.descItem);
                draw_sprite(spr_items, indiceInv, global.render_x+ render_width * 0.5 - modPanelItemsX + 8 + 16, global.render_y + render_height * 0.5 - modPanelItemsY + 9 + 32);
                draw_set_alpha(0.85);
            }
            
        }
        
        var posX = global.render_x+ render_width * 0.5 - 144;
        var posY = global.render_y + render_height * 0.5 - 113;
        
        var modY = 47 + posY;
        
        if (obj_panel_items.sectorPj) {
			draw_sprite(spr_panelitems_rectangle,0,posX + 150, modY + ( 8 * indicePanel) - 1)
        } else if (obj_panel_items.sectorNpc) {
			draw_sprite(spr_panelitems_rectangle,0,posX + 8, modY + ( 8 * indicePanel) - 1);
        }
        
    }
    
    
    draw_set_alpha(1);
    
    // Lista
    
    draw_set_color(c_white);
    var aux = 8;
    var i = aux;
    
    // Inventario
	
	for (var index = 0; index < 20; index++){
		//inventario user
		draw_text(global.render_x+ render_width * 0.5 - modPanelItemsX + 152, global.render_y + render_height * 0.5 - modPanelItemsY + 46 + (index * 8), string(obj_inventario.slots[index].nombre));
		//inventario npc
		draw_set_color(colorUsoItem(obj_panel_items.idPadre.slots[index].indice));
		draw_text(global.render_x+ render_width * 0.5 - modPanelItemsX + 8, global.render_y + render_height * 0.5 - modPanelItemsY + 46 + (index * 8), string(obj_panel_items.idPadre.slots[index].nombre));
		draw_set_color(c_white);
	}
    
    
    draw_set_font(fnt_Vedrana_7_bold);
    
}

// Panel trabajos

if (obj_panel_trabajos.mostrado) {
    
    draw_set_alpha(0.85);
    draw_sprite(spr_panel_trabajos, 0, global.render_x+ render_width * 0.5, global.render_y + render_height * 0.5);
    
    var modPanelItemsX = 144;
    var modPanelItemsY = 113;
    draw_set_font(fnt_Vedrana_5_bold);
    
    // Ícono y datos
    
    var indicePanel = obj_panel_trabajos.indiceItem;
    
    if (indicePanel != -1) {
    
        var indiceInv = obj_panel_trabajos.listaItems[indicePanel];
        
        if (indiceInv != -1) {
            draw_set_alpha(1);
            draw_set_color(c_white);
            draw_text(global.render_x+ render_width * 0.5 - modPanelItemsX + 47, global.render_y + render_height * 0.5 - modPanelItemsY + 12, string(obj_panel_trabajos.validoItem));
            draw_text(global.render_x+ render_width * 0.5 - modPanelItemsX + 47, global.render_y + render_height * 0.5 - modPanelItemsY + 20, obj_panel_trabajos.descItem);
            draw_text(global.render_x+ render_width * 0.5 - modPanelItemsX + 47, global.render_y + render_height * 0.5 - modPanelItemsY + 28, obj_panel_trabajos.elementosItem);
            draw_sprite(spr_items, indiceInv, global.render_x+ render_width * 0.5 - modPanelItemsX + 8 + 16, global.render_y + render_height * 0.5 - modPanelItemsY + 9 + 32);
            draw_set_alpha(0.85);
        }        
        
        var posX = global.render_x+ render_width * 0.5 - 144;
        var posY = global.render_y + render_height * 0.5 - 113;
        
        var modY = 47 + posY;
        
        //draw_set_color(c_gray);
        //draw_rectangle(posX + 8, modY + ( 8 * indicePanel) - 1, posX + 279, modY + ( 8 * (indicePanel + 1)) - 1, false);
        draw_sprite(spr_panelitems_rectangle2, 0 , posX + 8, modY + ( 8 * indicePanel) - 1)
        
    }
    
    if (obj_panel_trabajos.listaItems[0] == -1) {
        draw_set_alpha(1);
        draw_set_color(c_white);
        draw_text(global.render_x+ render_width * 0.5 - modPanelItemsX + 47, global.render_y + render_height * 0.5 - modPanelItemsY + 12, "No tenés skills suficientes para fabricar ningún ítem");
    }
    
    draw_set_alpha(1);
    
    // Lista
    
    draw_set_color(c_white);
    // Inventario
    
	for (var index = 0; index < 20; index++){
		//inventario
		draw_text(global.render_x+ render_width * 0.5 - modPanelItemsX + 8, global.render_y + render_height * 0.5 - modPanelItemsY + 46 + (index * 8), string(obj_panel_trabajos.nombreItems[index]));
	}
    
    draw_set_font(fnt_Vedrana_7_bold);
    
}


// Dopas

draw_set_color(c_white);
draw_set_halign(fa_center);
if (obj_pj.dopaAgilidad > 0) {
	draw_sprite_ext(spr_items, 218, global.render_x+ 88, global.render_y + 27, 0.75, 0.75, 0, -1, 1);
	draw_set_font(fnt_Vedrana_5_bold);
	draw_text_color(global.render_x+ 88, global.render_y, string(floor(obj_pj.dopaAgilidad * 25)) + "%", c_yellow, c_yellow, c_yellow, c_yellow, 1)
	draw_set_font(fnt_Vedrana_7_bold);
	if (obj_pj.tiempoDopa >= 80) draw_set_color(c_red);
	draw_text(global.render_x+ 88, global.render_y + 9, string(obj_pj.tiempoDopaMax - obj_pj.tiempoDopa))
	if (obj_pj.dopaFuerza > 0) {
		draw_sprite_ext(spr_items, 219, global.render_x+ 114, global.render_y + 27, 0.75, 0.75, 0, -1, 1);
		draw_set_font(fnt_Vedrana_5_bold);
		draw_text_color(global.render_x+ 114, global.render_y, string(floor(obj_pj.dopaFuerza * 25)) + "%", c_lime, c_lime, c_lime, c_lime, 1)
		draw_set_font(fnt_Vedrana_7_bold);
		if (obj_pj.tiempoDopa >= 80) draw_set_color(c_red);
		draw_text(global.render_x+ 114, global.render_y + 9, string(obj_pj.tiempoDopaMax - obj_pj.tiempoDopa))
	}	
} else if (obj_pj.dopaFuerza > 0) {
	draw_sprite_ext(spr_items, 219, global.render_x+ 88, global.render_y + 27, 0.75, 0.75, 0, -1, 1);
	draw_set_font(fnt_Vedrana_5_bold);
	draw_text_color(global.render_x+ 88, global.render_y, string(floor(obj_pj.dopaFuerza * 25)) + "%", c_lime, c_lime, c_lime, c_lime, 1)
	draw_set_font(fnt_Vedrana_7_bold);
	if (obj_pj.tiempoDopa >= 80) draw_set_color(c_red);		
	draw_text(global.render_x+ 88, global.render_y + 9, string(obj_pj.tiempoDopaMax - obj_pj.tiempoDopa))
}
draw_set_halign(fa_left);
draw_set_color(c_white);

// Panel

draw_sprite(spr_skills_libres, 0, global.render_x+ 65, global.render_y + 9);

if (obj_skills_libres.mostrado) {

    draw_sprite(spr_panel_skills, 0, global.render_x+ render_width * 0.5, global.render_y + render_height * 0.5);
    
    draw_set_font(fnt_Vedrana_6_bold);
    draw_set_color(c_white);
    draw_set_valign(fa_middle);
    draw_set_halign(fa_right);
    
    var hor = (global.render_x+ render_width * 0.5) - 64 + 109;
    var ver = (global.render_y + render_height * 0.5) - 108;
    
    draw_text((global.render_x+ render_width * 0.5) - 64 + 95, ver + 33, string(obj_pj.skillsLibres));
    
    draw_set_halign(fa_center);
    draw_set_font(fnt_Vedrana_5_bold);
    
    draw_text(hor, ver + 43, string(obj_pj.skills[0]));
    draw_text(hor, ver + 53, string(obj_pj.skills[1]));
    draw_text(hor, ver + 63, string(obj_pj.skills[2]));
    draw_text(hor, ver + 73, string(obj_pj.skills[3]));
    draw_text(hor, ver + 83, string(obj_pj.skills[4]));
    draw_text(hor, ver + 92, string(obj_pj.skills[5]));
    draw_text(hor, ver + 101, string(obj_pj.skills[6]));
    draw_text(hor, ver + 111, string(obj_pj.skills[7]));
    draw_text(hor, ver + 120, string(obj_pj.skills[8]));
    draw_text(hor, ver + 130, string(obj_pj.skills[9]));
    draw_text(hor, ver + 139, string(obj_pj.skills[10]));
    draw_text(hor, ver + 148, string(obj_pj.skills[11]));
    draw_text(hor, ver + 159, string(obj_pj.skills[12]));
    draw_text(hor, ver + 168, string(obj_pj.skills[13]));
    draw_text(hor, ver + 178, string(obj_pj.skills[14]));
    draw_text(hor, ver + 188, string(obj_pj.skills[15]));
    draw_text(hor, ver + 198, string(obj_pj.skills[16]));
    draw_text(hor, ver + 207, string(obj_pj.skills[17]));
    
    draw_set_valign(fa_top);
    draw_set_halign(fa_left);
    draw_set_font(fnt_Vedrana_7_bold);
    draw_set_color(c_silver);
    
}

if (panelActivo) {

    draw_text(global.render_x+ 4, global.render_y + 34, "Experiencia: " + string(obj_pj.experiencia) + "/" + string(obj_pj.expLvl[obj_pj.nivel]));
    draw_text(global.render_x+ 4, global.render_y + 34 + 10, "Fuerza: " + string(obtenerAtributoFuerzaPJ()));
    draw_text(global.render_x+ 4, global.render_y + 34 + 20, "Agilidad: " + string(obtenerAtributoAgilidadPJ()));
    draw_text(global.render_x+ 4, global.render_y + 34 + 30, "Inteligencia: " + string(obj_pj.atributos[2]));
    draw_text(global.render_x+ 4, global.render_y + 34 + 40, "Carisma: " + string(obj_pj.atributos[3]));
    draw_text(global.render_x+ 4, global.render_y + 34 + 50, "Constitución: " + string(obj_pj.atributos[4]));
    
    // Clase:

    // 0 = Arquero
    // 1 = Asesino
    // 2 = Bardo
    // 3 = Cazador
    // 4 = Clerigo
    // 5 = Druida
    // 6 = Guerrero
    // 7 = Mago
    // 8 = Paladin    
    
    clase = "";
    
    switch (obj_pj.clase) {
        case 0:
            clase = "Arquero";
            break;
        case 1:
            clase = "Asesino";
            break;
        case 2:
            clase = "Bardo";
            break;
        case 3:
            clase = "Cazador";
            break;
        case 4:
            clase = "Clérigo";
            break;
        case 5:
            clase = "Druida";
            break;
        case 6:
            clase = "Guerrero";
            break;
        case 7:
            clase = "Mago";
            break;
        case 8:
            clase = "Paladín";
            break;
    }
    
    draw_text(global.render_x+ 4, global.render_y + 34 + 60, "Clase: " + clase);
    
    var totalMatados = obj_pj.ciudadanosMatados + obj_pj.criminalesMatados;
    
    draw_text(global.render_x+ 4, global.render_y + 34 + 70, "Personas matadas: " + string(totalMatados));
    draw_text(global.render_x+ 4, global.render_y + 34 + 80, "Ciudadanos matados: " + string(obj_pj.ciudadanosMatados));
    draw_text(global.render_x+ 4, global.render_y + 34 + 90, "Criminales matados: " + string(obj_pj.criminalesMatados));
    
}

// Limpieza mundo

var _cleanup_seconds = -1;
if (online_activo()) {
    if (instance_exists(obj_online) && obj_online.playing && obj_online.cleanup_seconds >= 0) {
        var _cleanup_age = current_time - obj_online.cleanup_received_at;
        var _cleanup_limit = obj_online.cleanup_seconds == 0 ? ONLINE_CLEANUP_DONE_MS : ONLINE_CLEANUP_NOTICE_MAX_AGE_MS;
        if (_cleanup_age >= 0 && _cleanup_age <= _cleanup_limit)
            _cleanup_seconds = obj_online.cleanup_seconds;
    }
} else if (instance_exists(obj_limpieza_mundo) && obj_limpieza_mundo.contando) {
    _cleanup_seconds = obj_limpieza_mundo.segundos;
}
if (_cleanup_seconds >= 0) {
    draw_set_halign(fa_right);
    draw_set_color(c_white);
    if (_cleanup_seconds > 0) {
        draw_text(global.render_x+ render_width - 23, global.render_y + render_height - 16, "Limpieza de mundo en: " + string(_cleanup_seconds) + "s");
    } else {
        draw_text(global.render_x+ render_width - 23, global.render_y + render_height - 16, online_activo() ? "Limpieza de mundo realizada" : "Limpiando mundo...");
    }
    draw_set_halign(fa_left);
} 

/// Dibujo flechas

draw_set_alpha(0.15);
draw_sprite(spr_flechas, 0, global.render_x+ 70, global.render_y + render_height - 70); 
draw_set_alpha(1);
// Salud
dibujarBarra(global.inventario_x + 12, global.inventario_y + 14, obj_pj.salud, obj_pj.saludMax, colorVida);

// Maná
if (obj_pj.manaMax > 0) {
	dibujarBarra(global.inventario_x + 12, global.inventario_y + 24, obj_pj.mana, obj_pj.manaMax, colorMana);
}else{
	draw_sprite_ext(spr_barra_back, 0, global.inventario_x + 12, global.inventario_y + 24, 1, 1, 0, c_dkgray, 1 );
}

// Energía
dibujarBarra(global.inventario_x + 12, global.inventario_y + 34, obj_pj.energia, obj_pj.energiaMax, colorEnergia);

// Hambre

draw_set_font(fnt_Vedrana_6_bold);

dibujarBarraChica(global.inventario_x + 18, global.inventario_y + 44, obj_pj.hambre, obj_pj.hambreMax, colorHambre);
// Sed
dibujarBarraChica(global.inventario_x + 66, global.inventario_y + 44, obj_pj.sed, obj_pj.sedMax, colorSed);
// Oro

draw_set_font(fnt_Vedrana_7_bold);
draw_set_color(c_white);
draw_text(global.inventario_x + 30, global.inventario_y + 57, string(obj_pj.oro));

// Nombre de mapa y coordenadas

draw_set_font(fnt_Vedrana_6_bold);
draw_set_halign(fa_center);
draw_set_valign(fa_bottom);

draw_set_color(c_black);
draw_text(global.render_x+ render_width * 0.5, global.render_y + render_height - 2, nombreMapa + " - " + string(floor((obj_pj.x - 608) / 32) + 9) + " - " + string(floor((obj_pj.y - 400) / 32) + 7));

if (obj_mapas_mundo.mapas[room]) {
    draw_set_color(c_green);
} else {
    draw_set_color(c_silver);
}

draw_text(global.render_x+ render_width * 0.5 - 1, global.render_y + render_height - 3, nombreMapa + " - " + string(floor((obj_pj.x - 608) / 32) + 9) + " - " + string(floor((obj_pj.y - 400) / 32) + 7));

draw_set_halign(fa_left);
draw_set_valign(fa_top);

// Mejora la visibilidad de los items que se tiran al piso
    
if (
(obj_inventario.tirando || itemTiradoVisible) ||
obj_inventario.tiraDeA1
) {
    
    draw_set_halign(fa_center);
    draw_set_font(fnt_Vedrana_11_bold);
    
    if (
    (itemTiradoVisible && obj_tecla_T.teclaApretada) || 
    obj_inventario.tiraDeA1
    ) {
        if (obj_inventario.posSeleccionado != -1) {
        
            for (var i = 0; i < obj_inventario.maximoInv; i++) {
                if (obj_inventario.posSeleccionado == i) {
                    break;
                }
            }
            
            draw_set_color(c_black);
            draw_text(global.render_x+ render_width / 2, global.render_y + render_height - 30, string(obj_inventario.slots[i].cant)); 
            draw_set_color(c_white);
            draw_text(global.render_x+ render_width / 2 - 1, global.render_y + render_height - 31, string(obj_inventario.slots[i].cant)); 
            ultimaCantItemTirado = obj_inventario.slots[i].cant;    
            
        }
    } else if (!itemTiradoVisible && obj_tecla_T.teclaApretada) {
        draw_set_color(c_black);
        draw_text(global.render_x+ render_width / 2, global.render_y + render_height - 30, string(ultimaCantItemTirado));
        draw_set_color(c_white);
        draw_text(global.render_x+ render_width / 2 - 1, global.render_y + render_height - 31, string(ultimaCantItemTirado));
    }
    
    
    draw_set_color(c_black);
    draw_set_halign(fa_left);
    
    itemTiradoVisible = true;
    
    if (alarm[0] == -1 && obj_tecla_T.teclaApretada) {
        alarm[0] = 120;
    }
    
}

//Botones

with(obj_parent_botones){
	if (visible) draw_sprite(sprite_index,image_index,x,y)
}

/*

// FPS

draw_set_font(fnt_Vedrana_8_bold);
draw_set_color(c_white);
draw_set_halign(fa_right);
draw_text(view_xview[0] + view_wview[0] - 24, view_yview[0] + 4, "FPS: " + string(fps_real));

if (fps_real < minFPS) {
    minFPS = fps_real;
}

draw_text(view_xview[0] + view_wview[0] - 24, view_yview[0] + 16, "Min FPS: " + string(minFPS));
draw_set_halign(fa_left);

*/


/* */
/*  */
