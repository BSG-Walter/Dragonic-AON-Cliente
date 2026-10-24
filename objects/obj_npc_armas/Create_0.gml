/// @description  Estado inicial

hostil = false;
desc = "Bienvenido, tengo algunas armas que pueden ayudarte en tus viajes";

// Doble clic

dobleClic = false;

// Inventario

for (var i = 0; i < MAX_SLOTS; i++) {
    slots[i] = crearSlotNpc(-1, 0, "Vacío");
}

vecIndices = [0, 1, 2, 7, 8, 9, 10, 11, 12];
nroIndices = array_length(vecIndices);

for (var i = 0; i < nroIndices; i++) {
    item = vecIndices[i];
    slots[i] = crearSlotNpc(item, 1, configurarItem(item).nombre);
}
