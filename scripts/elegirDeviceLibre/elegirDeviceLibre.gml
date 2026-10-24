/// @description  elegirDeviceLibre()
function elegirDeviceLibre() {
    if (instance_exists(obj_pausa)) return -1;

	if (!obj_control_devices.devicesL[0]) {
	    return 0;
	} else if (!obj_control_devices.devicesL[1]) {
	    return 1;
	} else if (!obj_control_devices.devicesL[2]) {
	    return 2;
	} else if (!obj_control_devices.devicesL[3]) {
	    return 3;
	} else if (!obj_control_devices.devicesL[4]) {
	    return 4;
	} else {
	    return -1;
	}

}
