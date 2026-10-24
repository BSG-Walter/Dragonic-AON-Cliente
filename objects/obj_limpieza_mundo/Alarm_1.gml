/// @description  Limpia el mundo

if (online_activo()) exit;

with (obj_item_basic) {
    instance_destroy();
}

// Vacía vectores con items de todo el mundo

for (var j = obj_npcs_mundo.primerRoomDeMapa; j <= obj_npcs_mundo.totalRooms; j++) {
    for (var k = 0; k < array_length(obj_items_mundo.ItemsXRM[j]); k++) {
        obj_items_mundo.ItemsXRM[j, k] = itemMundoVacio();
    }
}

alarm[0] = 17100;

