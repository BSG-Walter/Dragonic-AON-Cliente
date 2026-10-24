/// @description  Estado inicial

hostil = false;
desc = "¡Hola! ¡Tengo las mejores manzanas de la zona, al mejor precio!";

// Doble clic

dobleClic = false;

// Inventario

for (var i = 0; i < MAX_SLOTS; i++) {
    slots[i] = crearSlotNpc(-1, 0, "Vacío");
}

vecIndices = [101, 102, 103, 104, 105, 110, 106, 109, 108, 107];
nroIndices = array_length(vecIndices);

for (var i = 0; i < nroIndices; i++) {
    item = vecIndices[i];
    slots[i] = crearSlotNpc(item, 1, configurarItem(item).nombre);
}
