/// @description  Estado inicial

hostil = false;
desc = "¡Hola forastero! Confeccionamos las mejores ropas de la zona";

// Doble clic

dobleClic = false;

// Inventario

for (var i = 0; i < MAX_SLOTS; i++) {
    slots[i] = crearSlotNpc(-1, 0, "Vacío");
}

vecIndices = [45, 46, 47, 48, 71, 53, 51, 52, 57, 55, 58, 62, 63, 64, 65, 159];
nroIndices = array_length(vecIndices);

for (var i = 0; i < nroIndices; i++) {
    item = vecIndices[i];
    slots[i] = crearSlotNpc(item, 1, configurarItem(item).nombre);
}
