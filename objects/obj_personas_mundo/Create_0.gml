/// @description  Matriz que lleva la cuenta de las personas de todo el mundo (Siempre 1)
/// @param Siempre 1

i = 0;
totalMultiIA = obj_opciones.maxBots; // El totalMultiIA indica que puede haber hasta 5 personas en total por todo el mundo

// Lista de rooms

totalRooms = obj_npcs_mundo.totalRooms;
primerRoomDeMapa = obj_npcs_mundo.primerRoomDeMapa;

globalIA[0] = datosIAVacio();

for (var i = 1; i < totalMultiIA; i++) {
    globalIA[i] = datosIAVacio();
}

itemsGlobalIA[0] = inventarioIAVacio();

for (var i = 1; i < totalMultiIA; i++) {
    itemsGlobalIA[i] = inventarioIAVacio();
}

direccionPJ = 0;

crea = false;
roomAnterior = -1;

PJInvi = false;

alarm[0] = 1
