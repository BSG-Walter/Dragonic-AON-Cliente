/// @description  Elije

obj_seleccionarPJ_borrar.confirmado = false;

if (global.online_elegir) {
    if (!instance_exists(obj_online) || !obj_online.characters_ready || obj_online.playing
        || obj_online.enter_pending || obj_online.create_pending || obj_online.delete_pending) exit;
    if (numPj <= array_length(obj_online.characters)) {
        obj_online.character_selected = numPj - 1;
        obj_control_seleccionarPJ.elegido = numPj;
    } else {
        obj_online.character_create_name = "";
        obj_online.status_text = "Elegí nombre, clase, raza, género y repartí las habilidades";
        online_creacion_limpiar();
        room_goto(rm_crearPJ);
    }
    exit;
}
if (elegible || !obj_control_seleccionarPJ.modoTorneo) {
	obj_control_seleccionarPJ.elegido = numPj;
	with(obj_importar_exportar) event_user(0)
	if (file_exists("partida" + string(numPj) + ".ini")){
	with (obj_restaurar_PJ) instance_destroy();
	if (obj_control_seleccionarPJ.datosPJ[numPj].nombre == "RESTAURAR_PERSONAJE")
		instance_create_depth(x, y + 111, 0, obj_restaurar_PJ);
	}
} else {
    dibujarErrorElegible = true;
    alarm[0] = 120;
}

