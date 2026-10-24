/// @description  Estado inicial
corregirPosNPCEnTelep();
roomInicial = room;
hostil = true;
image_speed = 0;
siguiendo = false;
direccion = 0;
puedeMoverse = true;
moviendose = false;
xInicio = x;
yInicio = y;
spd = 2;
envenena = false;
target = -1;
targetNPC = -1;
personaRoom = -1;
frame = 0;
intervaloAtaque = 120;
alarm[2] = random_range(intervaloAtaque, intervaloAtaque * 2);
alarm[3] = 1;
paralizado = false;
inmovilizado = false;
inicioParalisis = 0;
duracionParalisis = 0; //en milisegundos
alarm[10] = 30; //chequeamos cada 30 steps si seguimos paralizados o no.
dobleClic = false;
domable = false;
domado = false;
invocado = false;
oro = 0;
dropeaItem = false;
indItem = 0;
cantItem = 1;

