/// @description  clicMantenido se pone en false

if (online_activo() && clicMantenido) online_accion({op: "stop_work"});
clicMantenido = false;
deviceMantenido = -1;
alarm[1] = -1;
alarm[2] = -1;

