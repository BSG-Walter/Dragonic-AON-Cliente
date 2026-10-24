
if (global.online_exportando) exit;
if (global.online_modo && playing && is_ingame_room()) global.online_elegir = false;
// El online ya no importa personajes ni partidas offline: el servidor carga
// el personaje por nombre y entrega su estado autoritativo tras entered.
if (global.online_modo && room_reset_pending && is_ingame_room() && room_get_name(room) == world_room) {
    if (!instance_exists(obj_pj) || !instance_exists(obj_inventario)) crearObjetosBasicos(-1);
    online_limpiar_mapa();
    room_reset_pending = false;
}
if (global.online_modo && changing_room) online_room_listo();
if (failed_entry) {
    var _error = status_text;
    failed_entry = false;
    online_volver_menu();
    status_text = _error;
}
