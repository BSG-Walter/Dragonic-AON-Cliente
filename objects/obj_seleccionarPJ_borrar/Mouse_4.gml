/// @description  Borra

if (global.online_elegir) {
    obj_online.status_text = "No se pueden borrar personajes online desde este botón";
    exit;
}
if (obj_control_seleccionarPJ.elegido != -1) {
    if (file_exists("partida" + string(obj_control_seleccionarPJ.elegido) + ".ini")) {
        if (!confirmado) {
            confirmado = true;
            obj_seleccionarPJ_volver.dibujaWarningModoTorneo = false;
            alarm[0] = 120;
        }
    }
}

