/// @description  Borra

if (global.online_elegir) {
    if (!instance_exists(obj_online) || !obj_online.characters_ready
        || obj_online.playing || obj_online.enter_pending
        || obj_online.create_pending || obj_online.delete_pending) exit;
    var _index = obj_online.character_selected;
    if (_index < 0 || _index >= array_length(obj_online.characters)) {
        obj_online.status_text = "Seleccioná el personaje que querés borrar";
        exit;
    }
    confirmado = true;
    obj_online.status_text = "Confirmá el borrado de " + obj_online.characters[_index].nombre;
    obj_seleccionarPJ_volver.dibujaWarningModoTorneo = false;
    alarm[0] = SECOND * 2;
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

