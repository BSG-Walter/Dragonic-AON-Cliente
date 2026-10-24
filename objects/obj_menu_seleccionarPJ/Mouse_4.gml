if (instance_exists(obj_online) && obj_online.form_open) exit;
/// @description  Cambia de room

global.online_elegir = false;
hacerBackUpPartidas();
room_goto(rm_seleccionarPJ);

