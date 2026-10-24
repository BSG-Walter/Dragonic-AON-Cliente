/// @description  Control general / Control mouse

if (obj_ayuda.mostrado) {

    x = global.render_x + get_render_width() * 0.5 + 384 * 0.5 - 30;
    y = global.render_y + get_render_height() * 0.5 + 216 * 0.5 - 2;
    visible = true;
    
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
                
                if (obj_manual.pagina > 0) {
                    obj_manual.pagina--;
                } else {
                    obj_manual.pagina = obj_manual.totalPaginas;
                }
            
                obj_control_devices.devicesL[device] = false;
                
            }
            
        }
    
    }
    
} else {
    visible = false;
}

