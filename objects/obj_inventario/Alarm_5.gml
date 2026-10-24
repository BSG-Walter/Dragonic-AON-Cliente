/// @description  Crea el numpad

keyboard_key_press(ord("T"));
obj_tecla_T.teclaApretada = true;

if (
device_mouse_check_button(0, mb_left) ||
device_mouse_check_button(1, mb_left) ||
device_mouse_check_button(2, mb_left) ||
device_mouse_check_button(3, mb_left) ||
device_mouse_check_button(4, mb_left)
) {

    if (deviceDC != -1) {
    
        if (device_mouse_check_button(deviceDC, mb_left)) {
            
            if (posSeleccionado != -1) {
                instance_create_depth(global.render_x + get_render_width() * 0.5, global.render_y + get_render_height() * 0.5, 0, obj_numpad);
                
                obj_tecla_T.teclaApretada = false;
                timerAcelerador = 1;
                tirando = false;
                deviceDC = -1;     
            }               
                    
        }
        
    }

}





