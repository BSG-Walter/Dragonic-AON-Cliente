/// @description  Control general

//////////////////////////

personaRoom = elegirIAObjetivoNPCs();

target = obj_pj;

if (personaRoom != -1 && instance_exists(personaRoom) && !personaRoom.muerto) {
    if (
    obj_pj.invisible ||
    obj_pj.muerto ||
    (x < global.render_x || (x > global.render_x + get_render_width())) ||
    (y < global.render_y || (y > global.render_y + get_render_height()))
    ) {
        if (distance_to_object(personaRoom) <= 250) {
            target = personaRoom;
        }
    } else {
        if (distance_to_object(personaRoom) < distance_to_object(obj_pj)) {
            target = personaRoom;
        }
    }
}

if (target == obj_pj) {
    if (
    obj_pj.invisible ||
    obj_pj.muerto ||
    (x < global.render_x || (x > global.render_x + get_render_width())) ||
    (y < global.render_y || (y > global.render_y + get_render_height()))
    ) {
        target = -1;
    }
}

//////////////////////////
        
if (!siguiendo && !inmovilizado && !paralizado) {

    siguiendo = true;
    puedeMoverse = true;
    
    if (!moviendose) {
        
        if (target != -1) {
        
            xInicio = x;
            yInicio = y;
            
            if (y > target.y) {
            
                bloqueo = place_meeting(x, y - TILE_SIZE, obj_bloqueo_tierra);
                
                if (
                !place_meeting(x, y - TILE_SIZE, obj_pj) && 
                !place_meeting(x, y - TILE_SIZE, obj_npc_basic) && 
                !place_meeting(x, y - TILE_SIZE, obj_bloque_basic) && !place_meeting(x, y - TILE_SIZE, obj_telep) &&             
                !bloqueo
                ) {
                    alarm[1] = 1;
                    moviendose = true;
                    y -= spd;
                }
                
                direccion = 1;
                
            } else if (y < target.y) {
            
                bloqueo = place_meeting(x, y + TILE_SIZE, obj_bloqueo_tierra);
            
                if (
                !place_meeting(x, y + TILE_SIZE, obj_pj) && 
                !place_meeting(x, y + TILE_SIZE, obj_npc_basic) && 
                !place_meeting(x, y + TILE_SIZE, obj_bloque_basic) && !place_meeting(x, y + TILE_SIZE, obj_telep) &&         
                !bloqueo
                ) {
                    alarm[1] = 1;
                    moviendose = true;
                    y += spd;
                }
                
                direccion = 0;
                
            } else if (x > target.x) {
            
                bloqueo = place_meeting(x - TILE_SIZE, y, obj_bloqueo_tierra);
            
                if (
                !place_meeting(x - TILE_SIZE, y, obj_pj) && 
                !place_meeting(x - TILE_SIZE, y, obj_npc_basic) && 
                !place_meeting(x - TILE_SIZE, y, obj_bloque_basic) && !place_meeting(x - TILE_SIZE, y, obj_telep) &&   
                !bloqueo
                ) {
                    alarm[1] = 1;
                    moviendose = true;
                    x -= spd;
                }
                
                direccion = 2;
            
            } else if (x < target.x) {
            
                bloqueo = place_meeting(x + TILE_SIZE, y, obj_bloqueo_tierra);
            
                if (
                !place_meeting(x + TILE_SIZE, y, obj_pj) && 
                !place_meeting(x + TILE_SIZE, y, obj_npc_basic) && 
                !place_meeting(x + TILE_SIZE, y, obj_bloque_basic) && !place_meeting(x + TILE_SIZE, y, obj_telep) &&   
                !bloqueo
                ) {
                    alarm[1] = 1;
                    moviendose = true;
                    x += spd;
                }
                
                direccion = 3;
                
            }
        
        } else {
            siguiendo = false;
        }
        
    }
    
}

if (puedeMoverse) {

    switch (direccion) {
        case 0:
            if ((yInicio - y) / TILE_SIZE != round((yInicio - y) / TILE_SIZE)) {
                y += spd;
            } else {
                if (moviendose || puedeMoverse) {
                    moviendose = false;
                    puedeMoverse = false;
                    alarm[0] = 15.45;
                }
            }
            break;
        case 1:
            if ((y - yInicio) / TILE_SIZE != round((y - yInicio) / TILE_SIZE)) {
                y -= spd;
            } else {
                if (moviendose || puedeMoverse) {
                    moviendose = false;
                    puedeMoverse = false;
                    alarm[0] = 15.45;
                }
            }
            break;
        case 2:
            if ((xInicio - x) / TILE_SIZE != round((xInicio - x) / TILE_SIZE)) {
                x -= spd;
            } else {
                if (moviendose || puedeMoverse) {
                    moviendose = false;
                    puedeMoverse = false;
                    alarm[0] = 15.45;
                }
            }
            break;
        case 3:
            if ((x - xInicio) / TILE_SIZE != round((x - xInicio) / TILE_SIZE)) {
                x += spd;
            } else {
                if (moviendose || puedeMoverse) {
                    moviendose = false;
                    puedeMoverse = false;
                    alarm[0] = 15.45;
                }
            }
            break;
    }
    
}

// Depth

if (
(x >= global.render_x && (x <= global.render_x + get_render_width())) &&
(y >= global.render_y - get_render_width() * 0.5 && (y <= global.render_y + get_render_width() * 0.5))
) {

    if (y < obj_pj.y) {
        depth = obj_pj.depth + obj_pj.y - y;
    } else if (y > obj_pj.y) {
        depth = obj_pj.depth - y + obj_pj.y;
    } else {
        depth = obj_pj.depth;
    }

}

// Salud

if (salud <= 0) {
    instance_destroy();
}


/// Control mouse

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
            
            if (!dobleClic) {
                dobleClic = true;
                if (alarm[5] == -1) {
                    alarm[5] = 15;
                }
            } else {
                
                // No puede domar
                
                if (!obj_pj.muerto) {
                    var idINFO = instance_create_depth(obj_pj.x, obj_pj.y, 0, obj_INFO);
                    idINFO.padre = obj_pj.id;
                    idINFO.texto = "¡No podés domar a esta criatura!";
                } else {
                    var idINFO = instance_create_depth(obj_pj.x, obj_pj.y, 0, obj_INFO);
                    idINFO.padre = obj_pj.id;
                    idINFO.texto = "¡Estás muerto!";
                }
                
                dobleClic = false;
            
            }
            
            obj_control_devices.devicesL[device] = false;
            
        }
        
    }

}

