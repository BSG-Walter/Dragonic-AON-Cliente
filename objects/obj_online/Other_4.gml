// Room Start: los objetos del mapa ejecutan Step inmediatamente después.
// Preparar el PJ y su inventario antes de cualquier Step de la sala nueva.
if (global.online_exportando) exit;
if (global.online_modo && playing && room_reset_pending && is_ingame_room()
    && room_get_name(room) == world_room) {
    var _created_basic_objects = !instance_exists(obj_pj) || !instance_exists(obj_inventario);
    if (_created_basic_objects) crearObjetosBasicos(-1);
    online_limpiar_mapa();
    room_reset_pending = false;
    // Si obj_opciones recibió Room Start antes de la creación anterior,
    // reaplicar su configuración cuando sus dependencias ya existen.
    if (_created_basic_objects && instance_exists(obj_opciones)) {
        with (obj_opciones) event_perform(ev_other, ev_room_start);
    }
}
