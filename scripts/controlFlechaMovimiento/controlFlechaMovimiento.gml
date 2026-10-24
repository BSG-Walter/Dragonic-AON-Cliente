/// @description  controlFlechaMovimiento(flechaSinUso1, flechaSinUso2, flechaSinUso3)
/// @param flechaSinUso1
/// @param  flechaSinUso2
/// @param  flechaSinUso3
function controlFlechaMovimiento() {

	x = global.render_x+ 70; 
	y = global.render_y + get_render_height() - 70;

	var device = obj_area_flechas.deviceEnAreaFlechas

	if (device = -1) exit;

	var deviceEstaSobreLaFlecha = position_meeting(device_mouse_x(device), device_mouse_y(device), self)

	if (deviceEstaSobreLaFlecha && device_mouse_check_button(device, mb_left)) {
		apretada = true;
	}else{
		apretada = false;
	}

}