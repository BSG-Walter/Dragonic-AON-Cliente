if (online_activo() && instance_exists(obj_pausa)) exit;
/// @description  Depth / Control mouse

if (y < obj_pj.y) {
    depth = obj_pj.depth + obj_pj.y - y;
} else if (y > obj_pj.y) {
    depth = obj_pj.depth - y + obj_pj.y;
} else {
    depth = obj_pj.depth;
}

depth += HALF_TILE;

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
            
			yaHizoElPedido = online_activo() ? (variable_struct_exists(obj_online.state, "dragonic_ready") && obj_online.state.dragonic_ready > 0) : yaHizoPedidoHerrero();
			fechaDeTerminacion = online_activo() ? date_inc_second(date_current_datetime(), yaHizoElPedido ? obj_online.state.dragonic_ready - date_second_span(date_create_datetime(1970, 1, 1, 0, 0, 0), date_current_datetime()) : 0) : fechaDeTerminacionHerrero();
			
            if (!dobleClic) {
            
                obj_hechizos.moviendoHechizo = false;
                var idMsg = instance_create_depth(x, y, 0, obj_msg);
				if (!yaHizoElPedido) {
					idMsg.desc = desc;
				} else if (fechaDeTerminacion == -1 || date_compare_datetime(date_current_datetime(), fechaDeTerminacion) == -1) {
					var diferencia = date_second_span(date_current_datetime(), fechaDeTerminacion);
					idMsg.desc = desc3 + " (" + string(clamp(100 - floor(diferencia * 100 / ONLINE_DRAGONIC_SECONDS), 0, 100)) + "%)";
				} else {
					idMsg.desc = desc6;
				}
					
                dobleClic = true;
                alarm[0] = 15;
                
            } else {
            
	            if (!obj_pj.muerto) {
	                obj_hechizos.moviendoHechizo = false;
                
					if (online_activo()) {
                        online_accion({op: "dragonic", npc: online_npc_index(id)});
                        obj_control_devices.devicesL[device] = false;
                        exit;
                    }
                    if (yaHizoElPedido && date_compare_datetime(date_current_datetime(), fechaDeTerminacion) >= 0) {
						
						var indiceArmaduraDragonic = elegirArmaduraDragonic();
						
						if (tieneEspacioEnInv(indiceArmaduraDragonic, 1)) {
					
							// Otorga la armadura
							
							agarrarItemForzado(indiceArmaduraDragonic);
							
							var idMsg = instance_create_depth(x, y, 0, obj_msg);
							idMsg.desc = desc5;
							
							guardarPedidoHerrero(false, -1);
							guardarPartida(obj_pj.nombre);
						
						} else {
							var idMsg = instance_create_depth(x, y, 0, obj_msg);
							idMsg.desc = desc2;
						}
						
					} else if (!yaHizoElPedido) {
				
		                if (tieneElementosArmaduraDragonic()) {
							
							descontarElementosArmaduraDragonic();
							
							guardarPedidoHerrero(true, date_inc_day(date_current_datetime(), 1));
							guardarPartida(obj_pj.nombre);
							
							var idMsg = instance_create_depth(x, y, 0, obj_msg);
							idMsg.desc = desc4;
							
						} else {
							var idMsg = instance_create_depth(x, y, 0, obj_msg);
							idMsg.desc = desc1;
						}
					
					}
					
	            } else {
	                var idINFO = instance_create_depth(obj_pj.x, obj_pj.y, 0, obj_INFO);
	                idINFO.padre = obj_pj.id;
	                idINFO.texto = "¡Estás muerto!";
	            }
    
            }
            
            obj_control_devices.devicesL[device] = false;
            
        }
        
    }

}

