/// @description  Matriz que lleva la cuenta de los items de todo el mundo

i = 0;
ItemsRMActual[0] = -1;
datosItem = itemMundoVacio();

// Lista de rooms

totalRooms = obj_npcs_mundo.totalRooms;
primerRoomDeMapa = obj_npcs_mundo.primerRoomDeMapa;

for (var j = 0; j <= totalRooms; j++) {
    ItemsXRM[j, 0] = itemMundoVacio();
}

