/// @description  Estado inicial

hostil = false;
desc = "Ofrezco resistentes armaduras por un precio justo";

// Doble clic

dobleClic = false;

// Inventario

for (var i = 0; i < MAX_SLOTS; i++) {
    slots[i] = crearSlotNpc(-1, 0, "Vacío");
}

vecIndices = [85, 72, 73, 74, 212, 213, 75, 76, 77, 214, 83, 84, 215, 78, 79, 80, 81, 82, 216];
nroIndices = array_length(vecIndices);


for (var i = 0; i < nroIndices; i++) {
    item = vecIndices[i];
    slots[i] = crearSlotNpc(item, 1, configurarItem(item).nombre);
}
