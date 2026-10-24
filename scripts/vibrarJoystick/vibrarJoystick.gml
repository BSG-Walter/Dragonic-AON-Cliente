// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function vibrarJoystick(intensidad, tiempo){
	objVibracion = instance_create_depth(x, y, 0, obj_vibrar_joystick);
	objVibracion.alarm[0] = tiempo;
	gamepad_set_vibration(0, intensidad, intensidad);
}