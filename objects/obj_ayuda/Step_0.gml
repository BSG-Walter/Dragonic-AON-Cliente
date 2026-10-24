/// @description  Control general / control mouse

x = global.render_x + get_render_width() - 2;
y = global.render_y + 2;

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
            
            titilando = false;
            image_index = 0; 
            alarm[0] = -1;           
            
            if (mostrado) {
                mostrado = false;
            } else {
                mostrado = true;
                obj_configuracion.mostrado = false;
                obj_panel_opciones.visible = false;
            }
            
            obj_control_devices.devicesL[device] = false;
            
        }
        
    }

}

