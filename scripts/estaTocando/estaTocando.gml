// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function empieza_a_tocar(_id, _devuelve_id = false){
	var _touch_id = -1
	for (var i = 0; i < MAX_MULTITOUCH; i += 1) {
		if (device_mouse_check_button_pressed(i, mb_any)) {
			if (position_meeting(device_mouse_x(i), device_mouse_y(i), _id)) _touch_id = i;
		}
	}
	if (_devuelve_id) return _touch_id;
	return (_touch_id > -1)
}

function esta_tocando(_id, _touch){
	if (device_mouse_check_button(_touch, mb_any)) {
		if (position_meeting(device_mouse_x(_touch), device_mouse_y(_touch), _id)) return true;
	}
	return false;
}

function deja_de_tocar(_id, _touch){
	return device_mouse_check_button_released(_touch, mb_any)
}