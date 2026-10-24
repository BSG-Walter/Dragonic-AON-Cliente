/// @description  Cambia de room

if (online_creacion_activa()) {
    if (obj_online.create_pending) exit;
    online_creacion_volver();
}
else room_goto(rm_menuPrincipal);

