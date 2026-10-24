/// @description  Estado inicial

modoTorneo = !global.online_elegir && obj_control_notificacion_torneos.recibioNotificacion;

elegido = -1;

for (var i = 0; i <= 9; i++) {
    datosPJ[i] = slotPVacio();
}

// El selector de cuentas online nunca accede a partidas locales.
if (!global.online_elegir) {
    repararPartidasGuardadas();
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

if (modoTorneo) {
    room_goto(rm_seleccionarPJ);
    obj_control_notificacion_torneos.hayPJsAptos = false;
    obj_control_notificacion_torneos.recibioNotificacion = false;
}

