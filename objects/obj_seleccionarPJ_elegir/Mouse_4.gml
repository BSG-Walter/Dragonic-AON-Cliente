/// @description  Elige

if (global.online_elegir) {
    online_selector_entrar(obj_online.character_selected);
    exit;
}
if (obj_control_seleccionarPJ.elegido != -1) {
    if (file_exists("partida" + string(obj_control_seleccionarPJ.elegido) + ".ini")) {
        
        if (obj_control_seleccionarPJ.modoTorneo) {
        
            var _archivo = "partida" + string(obj_control_seleccionarPJ.elegido) + ".ini";
            partida_abrir(_archivo);
            
            // DEBUGGING (Mover PJ a la room de torneos)
            write("room", "room", rm_79);
            write("obj_pj", "x", 1296);
            write("obj_pj", "y", 1808);
            
            if (!partida_escribir(_archivo, ini_close())) {
                show_message("No se pudo guardar la partida");
                exit;
            }
                
            obj_control_seleccionarPJ.modoTorneo = false;
            obj_control_notificacion_torneos.hayPJsAptos = false;
            obj_control_notificacion_torneos.PJsAptosParaTorneo[0] = false;
            obj_control_notificacion_torneos.PJsAptosParaTorneo[1] = false;
            obj_control_notificacion_torneos.PJsAptosParaTorneo[2] = false;
            obj_control_notificacion_torneos.PJsAptosParaTorneo[3] = false;
            obj_control_notificacion_torneos.PJsAptosParaTorneo[4] = false;
            obj_control_notificacion_torneos.PJsAptosParaTorneo[5] = false;
            obj_control_notificacion_torneos.PJsAptosParaTorneo[6] = false;
            obj_control_notificacion_torneos.PJsAptosParaTorneo[7] = false;
            obj_control_notificacion_torneos.PJsAptosParaTorneo[8] = false;
            
        }
        
        cargarPartida(obj_control_seleccionarPJ.elegido);
        
    }
}

