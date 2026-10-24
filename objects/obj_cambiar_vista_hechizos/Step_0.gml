/// @description  Control mouses

visible = !obj_inventario.visible;
image_index = floor(real(!obj_hechizos.primerPanel));
			
x = global.inventario_x + 87;



var device = elegirDeviceLibre();

if (device != -1) {
    if (device_mouse_check_button_pressed(device, mb_left) && position_meeting(device_mouse_x(device), device_mouse_y(device), self)) {
        
        obj_control_devices.devicesL[device] = true;
            
		alternar_panel_hechizos()
            
        obj_control_devices.devicesL[device] = false;
            
    }

}


