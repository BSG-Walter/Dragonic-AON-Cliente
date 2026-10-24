/// @description  Control general / Control mouse

x = global.render_x + get_render_width();
y = global.render_y + get_render_height();

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
            
            if (online_activo()) { online_accion({op: "safe"}); exit; }
            var idINFO = instance_create_depth(obj_pj.x, obj_pj.y, 0, obj_INFO);
    
            if (activo) {
                idINFO.texto = "Seguro desactivado";
                activo = false;
            } else {
                idINFO.texto = "Seguro activado";
                activo = true;
            }
            
            obj_control_devices.devicesL[device] = false;
            
        }
        
    }

}

