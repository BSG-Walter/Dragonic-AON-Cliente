/// @description  Elige

if (!global.online_elegir && obj_control_seleccionarPJ.elegido != -1) {
    var _elegido = obj_control_seleccionarPJ.elegido;
    var _archivo = "partida" + string(_elegido) + ".ini";
    var _backup = "partida" + string(_elegido) + "_BackUp.ini";

    if (partidaLegible(_backup, true) && partida_copiar_verificada(_backup, _archivo)) {
        with (obj_control_seleccionarPJ) {
            cargarPJs(_elegido);
        }
        instance_destroy();
    }
}

