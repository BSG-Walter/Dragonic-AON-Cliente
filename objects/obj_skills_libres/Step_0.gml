/// @description  Control general / Control mouse

x = global.render_x + 65;
y = global.render_y + 9;

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

            if (mostrado) {
                mostrado = false;
            } else {
                mostrado = true;
                if (online_activo()) online_accion({op: "skill_open"});
                with (obj_boton_panel_skills_izq) {
                    skillsIniciales = obj_pj.skills[indice];
                }
            }
            
            obj_control_devices.devicesL[device] = false;
            
        }
        
    }

}

