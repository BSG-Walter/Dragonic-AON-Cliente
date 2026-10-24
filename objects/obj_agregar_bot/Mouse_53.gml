/// @description  Control general / Control mouse

// La posición base se sigue definiendo en obj_gui, por ahora la dejamos así.
x = global.render_x + get_render_width() - 2;
y = global.render_y + 50;

// Calculo el centro de los botones usando las variables
var pk_x_center = x - radio;
var pk_y_center = y + radio;
var ciuda_x_center = pk_x_center;
var ciuda_y_center = pk_y_center + espacio_vertical;

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
    
        if (device_mouse_check_button_pressed(device, mb_left) && point_distance(device_mouse_x(device), device_mouse_y(device), pk_x_center, pk_y_center) <= radio) {
        
            obj_control_devices.devicesL[device] = true;
			
            spawnear_pk = false;
			if (room == rm_arena){
				if (online_activo()) online_accion({op: "arena_bot", pk: spawnear_pk});
                else instance_create_depth(obj_pj.x, obj_pj.y + TILE_SIZE, 0, obj_persona);
			}
            
            obj_control_devices.devicesL[device] = false;
            
        }
		
		if (device_mouse_check_button_pressed(device, mb_left) && point_distance(device_mouse_x(device), device_mouse_y(device), ciuda_x_center, ciuda_y_center) <= radio) {
        
            obj_control_devices.devicesL[device] = true;
			
            spawnear_pk = true;
			if (room == rm_arena){
				if (online_activo()) online_accion({op: "arena_bot", pk: spawnear_pk});
                else instance_create_depth(obj_pj.x, obj_pj.y + TILE_SIZE, 0, obj_persona);
			}
            
            obj_control_devices.devicesL[device] = false;
            
        }
        
    }

}
