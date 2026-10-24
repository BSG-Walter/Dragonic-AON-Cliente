/// @description  Borra

if (global.online_elegir) {
    if (!instance_exists(obj_online) || !obj_seleccionarPJ_borrar.confirmado
        || obj_online.delete_pending || obj_online.playing
        || !obj_online.characters_ready) exit;
    var _index = obj_online.character_selected;
    if (_index < 0 || _index >= array_length(obj_online.characters)) exit;
    var _nombre = obj_online.characters[_index].nombre;
    if (online_enviar({op: "delete_character", name: _nombre})) {
        obj_online.delete_pending = true;
        obj_online.delete_name = _nombre;
        obj_online.status_text = "Borrando " + _nombre + "...";
        obj_seleccionarPJ_borrar.confirmado = false;
        obj_seleccionarPJ_borrar.alarm[0] = -1;
    }
    exit;
}
if (obj_control_seleccionarPJ.elegido != -1) {
    if (file_exists("partida" + string(obj_control_seleccionarPJ.elegido) + ".ini")) {
        if (obj_seleccionarPJ_borrar.confirmado) {
            obj_seleccionarPJ_borrar.alarm[0] = -1;
			if (file_exists("herrero-" + obj_control_seleccionarPJ.datosPJ[obj_control_seleccionarPJ.elegido].nombre + ".ini"))
				file_delete("herrero-" + obj_control_seleccionarPJ.datosPJ[obj_control_seleccionarPJ.elegido].nombre + ".ini");
            if (file_exists("partida" + string(obj_control_seleccionarPJ.elegido) + "_BackUp.ini")) {
				file_delete("partida" + string(obj_control_seleccionarPJ.elegido) + "_BackUp.ini");
            }
            file_delete("partida" + string(obj_control_seleccionarPJ.elegido) + ".ini");
				
            for (var i = obj_control_seleccionarPJ.elegido + 1; i < 10; i++) {
                if (file_exists("partida" + string(i) + ".ini")) {
                    file_rename("partida" + string(i) + ".ini", "partida" + string(i - 1) + ".ini");
                }
                if (file_exists("partida" + string(i) + "_BackUp.ini")) {
                    file_rename("partida" + string(i) + "_BackUp.ini", "partida" + string(i - 1) + "_BackUp.ini");
                }
            }
            with (obj_control_seleccionarPJ) {
                cargarPJs(1);
                cargarPJs(2);
                cargarPJs(3);
                cargarPJs(4);
                cargarPJs(5);
                cargarPJs(6);
                cargarPJs(7);
                cargarPJs(8);
                cargarPJs(9);
            }
			with(obj_importar_exportar) event_user(0);
            obj_seleccionarPJ_borrar.confirmado = false;
			with (obj_restaurar_PJ) instance_destroy(); 
        }
    }
}

